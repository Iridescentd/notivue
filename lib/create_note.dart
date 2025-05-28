import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';
import 'services/note_service.dart';
import 'models/note.dart';
import 'utils/constants.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class CreateNoteScreen extends StatefulWidget {
  final Note? noteToEdit;

  const CreateNoteScreen({super.key, this.noteToEdit});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final _titleController = TextEditingController();
  late QuillController _quillController;
  final _noteService = NoteService();
  final _editorFocusNode = FocusNode();
  final _scrollController = ScrollController();
  bool _isLoading = false;
  String? _errorMessage;
  List<String> _selectedTags = [];

  bool get _isEditing => widget.noteToEdit != null;

  @override
  void initState() {
    super.initState();
    _checkSession();

    if (_isEditing) {
      _titleController.text = widget.noteToEdit!.title;
      _selectedTags = List<String>.from(widget.noteToEdit!.tags);
      try {
        final contentJson = jsonDecode(widget.noteToEdit!.content);
        _quillController = QuillController(
          document: Document.fromJson(contentJson),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        _quillController = QuillController.basic();
        debugPrint(
            "Error decoding Quill content: $e. Falling back to basic controller.");
      }
    } else {
      _quillController = QuillController.basic();
    }
  }

  Future<void> _checkSession() async {
    final user = supabase.auth.currentUser;
    if (user == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to create or edit notes'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  Future<void> _saveNote() async {
    if (_titleController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a title';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final content = jsonEncode(_quillController.document.toDelta().toJson());

      if (_isEditing) {
        final updatedNote = widget.noteToEdit!.copyWith(
          title: _titleController.text.trim(),
          content: content,
          tags: _selectedTags,
        );
        final note = await _noteService.updateNote(updatedNote);
        if (note != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note updated successfully')),
          );
          Navigator.pop(context, true);
        } else {
          throw Exception('Failed to update note');
        }
      } else {
        final note = await _noteService.createNote(
          title: _titleController.text.trim(),
          content: content,
          tags: _selectedTags,
        );

        if (note != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note saved successfully')),
          );
          Navigator.pop(context, true);
        } else {
          throw Exception('Failed to save note');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  void _addTag(String tag) {
    if (tag.trim().isEmpty) return;
    if (!_selectedTags.contains(tag.trim())) {
      setState(() {
        _selectedTags.add(tag.trim());
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _selectedTags.remove(tag);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _editorFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Note' : 'Create Note',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveNote,
              tooltip: _isEditing ? 'Update Note' : 'Save Note',
            ),
        ],
      ),
      body: Column(
        children: [
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.red[100],
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red[700], fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _titleController,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'Note Title',
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._selectedTags.map((tag) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text(tag,
                              style: GoogleFonts.pangolin(fontSize: 14)),
                          onDeleted: () => _removeTag(tag),
                          deleteIconColor: Colors.red[700],
                          backgroundColor: Colors.grey[300],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 0),
                        ),
                      )),
                  ActionChip(
                    avatar: Icon(Icons.add, color: Colors.blue[700]),
                    label: Text('Add Tag',
                        style: GoogleFonts.pangolin(
                            fontSize: 14, color: Colors.blue[800])),
                    backgroundColor: Colors.blue[100],
                    onPressed: () {
                      final tagController = TextEditingController();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                Text('Add Tag', style: GoogleFonts.poppins()),
                            content: TextField(
                              controller: tagController,
                              decoration: InputDecoration(
                                hintText: 'Enter tag name',
                                hintStyle: GoogleFonts.pangolin(),
                              ),
                              onSubmitted: (value) {
                                _addTag(value);
                                Navigator.pop(context);
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _addTag(tagController.text);
                                  Navigator.pop(context);
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  QuillToolbar.simple(
                    configurations: QuillSimpleToolbarConfigurations(
                      controller: _quillController,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('en'),
                      ),
                      buttonOptions: QuillSimpleToolbarButtonOptions(
                        fontFamily: QuillToolbarFontFamilyButtonOptions(
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        fontSize: QuillToolbarFontSizeButtonOptions(
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ),
                      multiRowsDisplay: false,
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: _quillController,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('en'),
                          ),
                          expands: true,
                          padding: const EdgeInsets.all(8),
                          placeholder: 'Start writing your note...',
                          customStyles: DefaultStyles(
                            paragraph: DefaultTextBlockStyle(
                              GoogleFonts.poppins(fontSize: 16, height: 1.5),
                              const VerticalSpacing(6, 0),
                              const VerticalSpacing(6, 0),
                              null,
                            ),
                            h1: DefaultTextBlockStyle(
                              GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                              const VerticalSpacing(10, 0),
                              const VerticalSpacing(4, 0),
                              null,
                            ),
                            h2: DefaultTextBlockStyle(
                              GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5),
                              const VerticalSpacing(8, 0),
                              const VerticalSpacing(4, 0),
                              null,
                            ),
                            h3: DefaultTextBlockStyle(
                              GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5),
                              const VerticalSpacing(6, 0),
                              const VerticalSpacing(2, 0),
                              null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
