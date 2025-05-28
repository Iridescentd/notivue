import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/constants.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Show splash for 2 seconds
    if (!mounted) return;

    try {
      // Get current session and check if it's valid
      final session = supabase.auth.currentSession;
      final user = supabase.auth.currentUser;

      if (session != null && user != null) {
        // Check if session is expired
        final now = DateTime.now().toUtc();
        final expiresAt = DateTime.fromMillisecondsSinceEpoch(
          session.expiresAt! * 1000,
          isUtc: true,
        );

        if (now.isBefore(expiresAt)) {
          // Valid session exists
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/dashboard');
            return;
          }
        }
      }

      // No valid session
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      // Handle any errors by redirecting to login screen as a fallback
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF56618A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 242,
              height: 96,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo-white.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 32),
            // Welcome text
            Text(
              'Welcome to Notivue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: GoogleFonts.righteous().fontFamily,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
