import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Load user profile from Supabase
  Future<UserModel?> loadUserProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      _currentUser = UserModel.fromSupabase(user, response);
      return _currentUser;
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }

  // Create new user profile
  Future<UserModel?> createUserProfile({
    required String userId,
    required String email,
    required String name,
    String? dateOfBirth,
    String? gender,
  }) async {
    try {
      final now = DateTime.now();
      final data = {
        'id': userId,
        'email': email,
        'name': name,
        'date_of_birth': dateOfBirth,
        'gender': gender,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      await supabase.from('profiles').insert(data);

      final user = supabase.auth.currentUser;
      if (user != null) {
        _currentUser = UserModel(
          id: userId,
          email: email,
          name: name,
          dateOfBirth: dateOfBirth,
          gender: gender,
          createdAt: now,
          updatedAt: now,
        );
      }

      return _currentUser;
    } catch (e) {
      print('Error creating user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<UserModel?> updateUserProfile({
    required String name,
    String? dateOfBirth,
    String? gender,
  }) async {
    try {
      if (_currentUser == null) return null;

      final data = {
        'name': name,
        'date_of_birth': dateOfBirth,
        'gender': gender,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await supabase
          .from('profiles')
          .update(data)
          .eq('id', _currentUser!.id);

      _currentUser = _currentUser!.copyWith(
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      return _currentUser;
    } catch (e) {
      print('Error updating user profile: $e');
      return null;
    }
  }

  // Sign out and clear current user
  Future<void> signOut() async {
    await supabase.auth.signOut();
    _currentUser = null;
  }
} 