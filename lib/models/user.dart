import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String? dateOfBirth;
  final String? gender;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.dateOfBirth,
    this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a UserModel from Supabase Auth User and Profile data
  factory UserModel.fromSupabase(User user, Map<String, dynamic> profile) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: profile['name'] ?? '',
      dateOfBirth: profile['date_of_birth'],
      gender: profile['gender'],
      createdAt: DateTime.parse(profile['created_at']),
      updatedAt: DateTime.parse(profile['updated_at']),
    );
  }

  // Convert UserModel to JSON for storing in Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create a copy of UserModel with some updated fields
  UserModel copyWith({
    String? name,
    String? dateOfBirth,
    String? gender,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  // Get user initials for avatar
  String get initials {
    if (name.isEmpty) return '??';
    final nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length > 1 ? 2 : 1).toUpperCase();
  }

  // Format date of birth for display
  String get formattedDateOfBirth {
    if (dateOfBirth == null) return 'Not set';
    final date = DateTime.parse(dateOfBirth!);
    return '${date.day}/${date.month}/${date.year}';
  }
} 