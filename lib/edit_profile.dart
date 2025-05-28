import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'utils/constants.dart';
import 'dart:math';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _loading = true;
  String? _error;
  Map<String, dynamic>? _profile;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not found');

      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      setState(() {
        _profile = response;
        _nameController.text = response['name'] ?? '';
        _emailController.text = user.email ?? '';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _loading = true);

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not found');

      // Update profile
      await supabase.from('profiles').update({
        'name': _nameController.text.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', user.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: $_error'),
        ),
      );
    }

    final user = supabase.auth.currentUser;
    final initials = _nameController.text.isNotEmpty
        ? _nameController.text.substring(0, min(2, _nameController.text.length)).toUpperCase()
        : '??';

    return Scaffold(
      body: Stack(
        children: [
          // Custom curved background
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: BackgroundPainter(),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and title
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/logo-white.png',
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                ),

                // Profile picture section
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: const Color(0xFFFCE4EC),
                        child: Text(
                          initials,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black87,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD700),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Form fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FULL NAME',
                        style: TextStyle(
                          color: const Color(0xFF1B1D2E),
                          fontSize: 16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                        style: TextStyle(
                          color: const Color(0xFF1B1D2E),
                          fontSize: 20,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'EMAIL ADDRESS',
                        style: TextStyle(
                          color: const Color(0xFF1B1D2E),
                          fontSize: 16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _emailController.text,
                        style: TextStyle(
                          color: const Color(0xFF1B1D2E),
                          fontSize: 20,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF73CAA0),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _loading
                              ? const CircularProgressIndicator()
                              : const Text('Save Changes'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5C6BC0) // Dark purple color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.7);
    
    // Create the curved line
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width,
      size.height * 0.8,
    );
    
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Draw the light purple background
    final bgPaint = Paint()
      ..color = const Color(0xFFE6E6FA) // Light purple color
      ..style = PaintingStyle.fill;

    final bgPath = Path();
    bgPath.moveTo(0, size.height * 0.7);
    bgPath.lineTo(0, size.height);
    bgPath.lineTo(size.width, size.height);
    bgPath.lineTo(size.width, size.height * 0.8);
    
    bgPath.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width * 0.5,
      size.height * 0.8,
    );
    bgPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      0,
      size.height * 0.7,
    );
    
    canvas.drawPath(bgPath, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 