import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA), // Light purple background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Header with back button and title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromRGBO(27, 29, 46, 1),
                        fontSize: 35,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Menambahkan IconButton kosong untuk menyeimbangkan layout
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                    onPressed: null,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Profile Section
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFFFCE4EC), // Light pink
                    child: const Text(
                      'AN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                 Text(
                    'Anjasyah Naufal',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Profile Settings Section
              Column(
                children: [
                  _buildSettingsItem(
                    context,
                    'Edit profile',
                    Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    context,
                    'Change password',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    context,
                    'Privacy & Security',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Notifications Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_none, size: 40),
                        const SizedBox(width: 8),
                        Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsItem(
                    context,
                    'Notifications',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    context,
                    'App Notifications',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Other Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: [
                        const Icon(Icons.menu, size: 40),
                        const SizedBox(width: 8),
                        Text(
                          'Other',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsItem(
                    context,
                    'Language',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    context,
                    'Appearance',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    context,
                    'About app',
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                ],
              ),
              const Spacer(),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData trailingIcon, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 30.0, right: 30.0),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      trailing: Icon(trailingIcon, size: 16),
      onTap: onTap,
    );
  }
} 