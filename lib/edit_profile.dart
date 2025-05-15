import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            'edit profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Notivue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: GoogleFonts.pacifico().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
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
                          'AN',
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
                      _buildFormField('USERNAME', '@AnjasyahNaufal00'),
                      const SizedBox(height: 30),
                      _buildFormField('FULLNAME', 'Anjasyah Naufal'),
                      const SizedBox(height: 30),
                      _buildFormField('EMAIL ADDRESS', '@AnjasyahNaufal123@gmail.com'),
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

  Widget _buildFormField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF1B1D2E),
            fontSize: 16,
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF1B1D2E),
            fontSize: 20,
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
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