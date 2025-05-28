import 'dart:convert';

class Note {
  final String id;
  final String title;
  final String content;
  final String userId;
  final List<String> tags;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    this.tags = const [],
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a Note from Supabase data
  factory Note.fromJson(Map<String, dynamic> json) {
    // Handle tags array from Supabase
    List<String> parseTags(dynamic tagsData) {
      if (tagsData == null) return [];
      if (tagsData is List) {
        return tagsData.map((tag) => tag.toString()).toList();
      }
      return [];
    }

    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      userId: json['user_id'],
      tags: parseTags(json['tags']),
      isCompleted: json['is_completed'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert Note to JSON for storing in Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'tags': tags,
      'is_completed': isCompleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create a copy of Note with some updated fields
  Note copyWith({
    String? title,
    String? content,
    List<String>? tags,
    bool? isCompleted,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId,
      tags: tags ?? this.tags,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  // Get the first few words of content as preview
  String get preview {
    try {
      final decoded = jsonDecode(content);
      if (decoded is List) {
        final plainText = decoded
            .map((op) => op['insert'] ?? '')
            .join('')
            .trim();
        return plainText.length > 100 
            ? '${plainText.substring(0, 100)}...' 
            : plainText;
      }
      return content.length > 100 ? '${content.substring(0, 100)}...' : content;
    } catch (e) {
      return content.length > 100 ? '${content.substring(0, 100)}...' : content;
    }
  }
} 