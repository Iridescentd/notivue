import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 922,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF56618A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              // Background image at the bottom
              Positioned(
                left: 0,
                right: 0,
                top: 450,
                child: Image.asset(
                  "assets/images/bg-splash.png",
                  fit: BoxFit.contain,
                  height: 550, // or BoxFit.fill/BoxFit.fitHeight as needed
                ),
              ),
              Positioned(
                left: 96,
                top: 240,
                child: Container(
                  width: 242,
                  height: 96,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo-white.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 87,
                top: 93,
                child: SizedBox(
                  width: 259,
                  height: 147,
                  child: Text(
                    'welcome\nto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: GoogleFonts.righteous().fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 1.15,
                      letterSpacing: 4.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 615,
                child: SizedBox(
                  width: 330,
                  height: 32,
                  child: Text(
                    'I’m new to notivue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1F202B),
                      fontSize: 28,
                      fontFamily: GoogleFonts.pangolin().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned( 
                left: 0,
                right: 0,
                top: 830,
                child: Center(
                  child: SizedBox(
                    width: 330,
                    height: 51,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7F7F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          width: 3,
                          color: Color(0xFF40413F),
                        ),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // TODO: Tambahkan aksi ketika tombol Log in ditekan
                    },
                    child: const Text(
                      'Log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color(0xFF1F202B),
                      fontSize: 28,
                      fontFamily: 'Gilroy-SemiBold',
                      fontWeight: FontWeight.w400,
                    ),
                  ),  

                  ),
                ),  
                ),
              ),
              Positioned(
                left: 50,
                top: 657,
                child: SizedBox(
                  width: 330,
                  height: 51,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF73CAA0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          width: 3,
                          color: Color(0xFF40413F),
                        ),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // TODO: Tambahkan aksi ketika tombol Sign up ditekan
                    },
                    child: const Text(
                      'Sign up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1F202B),
                        fontSize: 28,
                        fontFamily: 'Gilroy-SemiBold',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 87,
                top: 745,
                child: SizedBox(
                  width: 256,
                  height: 70,
                  child: Text(
                    'I’m coming back to notivue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1F202B),
                      fontSize: 28,
                      fontFamily: GoogleFonts.pangolin().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
