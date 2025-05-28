import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note.dart';
import '../utils/constants.dart';

class NoteService {
  static final NoteService _instance = NoteService._internal();
  factory NoteService() => _instance;
  NoteService._internal();

  // Create a new note
  Future<Note?> createNote({
    required String title,
    required String content,
    List<String> tags = const [],
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final now = DateTime.now().toIso8601String();
      final noteData = {
        'title': title,
        'content': content,
        'user_id': user.id,
        'tags': tags, // Supabase will handle array conversion
        'is_completed': false,
        'created_at': now,
        'updated_at': now,
      };

      final response = await supabase
          .from('notes')
          .insert(noteData)
          .select()
          .single();

      return Note.fromJson(response);
    } catch (e) {
      print('Error creating note: $e');
      rethrow; // Rethrow to handle in UI
    }
  }

  // Get all notes for current user
  Future<List<Note>> getNotes() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final response = await supabase
          .from('notes')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return (response as List)
          .map((note) => Note.fromJson(note))
          .toList();
    } catch (e) {
      print('Error getting notes: $e');
      rethrow; // Rethrow to handle in UI
    }
  }

  // Update a note
  Future<Note?> updateNote(Note note) async {
    try {
      final response = await supabase
          .from('notes')
          .update({
            'title': note.title,
            'content': note.content,
            'tags': note.tags,
            'is_completed': note.isCompleted,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', note.id)
          .select()
          .single();

      return Note.fromJson(response);
    } catch (e) {
      print('Error updating note: $e');
      rethrow; // Rethrow to handle in UI
    }
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      await supabase
          .from('notes')
          .delete()
          .eq('id', noteId);
    } catch (e) {
      print('Error deleting note: $e');
      rethrow; // Rethrow to handle in UI
    }
  }

  // Toggle note completion status
  Future<Note?> toggleNoteCompletion(Note note) async {
    try {
      final updatedNote = note.copyWith(isCompleted: !note.isCompleted);
      return await updateNote(updatedNote);
    } catch (e) {
      print('Error toggling note completion: $e');
      rethrow; // Rethrow to handle in UI
    }
  }
} 