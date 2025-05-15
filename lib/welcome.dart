import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF6B7296);
    const buttonColor = Color(0xFFF6E7A6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // Judul
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'The best time to\nstart is now!',
                textAlign: TextAlign.center,
                style: GoogleFonts.righteous(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Deskripsi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'You Taking the first step in changing\nyour life. Let us guide you through it.',
                textAlign: TextAlign.center,
                style: GoogleFonts.pangolin(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Ilustrasi tangan
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Gambar tangan (ganti dengan asetmu)
                    Image.asset(
                      'assets/images/group.png',
                      width: 890,
                      height: 920,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            // Tombol
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, left: 24, right: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 1,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "LET'S DO IT",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
