import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/constants.dart';
import 'dart:math';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _loading = true;
  String? _error;
  Map<String, dynamic>? _profile;

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
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Widget _buildSettingItem(String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: onTap,
    );
  }

  Widget _buildSectionTitle(String title, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.black87, size: 24),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up any controllers or listeners here if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final name = _profile?['name'] as String? ?? 'User';
    final initials = name.isNotEmpty
        ? name.substring(0, min(2, name.length)).toUpperCase()
        : '??';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE6E6FA), // Lavender background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
          ),
          title: Text(
            'Settings',
            style: GoogleFonts.poppins(
              fontSize: 28,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Section
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.purple[100],
                            child: Text(
                              initials,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            name,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (user?.email != null)
                            Text(
                              user!.email!,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Account Settings
                    const SizedBox(height: 20),
                    _buildSettingItem(
                      'Edit profile',
                      onTap: () async {
                        final result = await Navigator.pushNamed(context, '/edit_profile');
                        if (result == true) {
                          _loadProfile(); // Reload profile after editing
                        }
                      },
                    ),
                    _buildSettingItem(
                      'Change password',
                      onTap: () {
                        // Handle change password
                      },
                    ),
                    _buildSettingItem(
                      'Privacy & Security',
                      onTap: () {
                        // Handle privacy settings
                      },
                    ),

                    // Notifications Section
                    _buildSectionTitle('Notifications', Icons.notifications_none),
                    _buildSettingItem(
                      'Notifications',
                      onTap: () {
                        // Handle notifications
                      },
                    ),
                    _buildSettingItem(
                      'App Notifications',
                      onTap: () {
                        // Handle app notifications
                      },
                    ),

                    // Other Section
                    _buildSectionTitle('Other', Icons.menu),
                    _buildSettingItem(
                      'Language',
                      onTap: () {
                        // Handle language settings
                      },
                    ),
                    _buildSettingItem(
                      'Appearance',
                      onTap: () {
                        // Handle appearance settings
                      },
                    ),
                    _buildSettingItem(
                      'About app',
                      onTap: () {
                        // Handle about app
                      },
                    ),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B6B),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          try {
                            await supabase.auth.signOut();
                            if (mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error signing out: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
} 