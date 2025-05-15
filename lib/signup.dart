import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? selectedGender;
  bool agreeTerms = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 430,
            height: 932,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF56618A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 100,
                  child: SizedBox(
                    width: 300,
                    height: 104,
                    child: Text(
                      "Let's get you onboard!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: GoogleFonts.righteous().fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 1.15,
                        letterSpacing: 3.15,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 240,
                  child: Container(
                    width: 369,
                    height: 540,
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 19,
                      right: 19,
                      bottom: 40,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD0D7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          height: 32,
                          child: Text(
                            'Tell us your name',
                            style: TextStyle(
                              color: const Color(0xFF1F202B),
                              fontSize: 24,
                              fontFamily: GoogleFonts.pangolin().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 330,
                          height: 40,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 220,
                          height: 32,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: const Color(0xFF1F202B),
                              fontSize: 24,
                              fontFamily: GoogleFonts.pangolin().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 330,
                          height: 40,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 220,
                          height: 32,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: const Color(0xFF1F202B),
                              fontSize: 24,
                              fontFamily: GoogleFonts.pangolin().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 330,
                          height: 40,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 220,
                          height: 32,
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              color: const Color(0xFF1F202B),
                              fontSize: 24,
                              fontFamily: GoogleFonts.pangolin().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 330,
                          height: 40,
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 220,
                          height: 32,
                          child: Text(
                            'Date of Birth',
                            style: TextStyle(
                              color: const Color(0xFF1F202B),
                              fontSize: 24,
                              fontFamily: GoogleFonts.pangolin().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 330,
                          height: 40,
                          child: TextField(
                            controller: dobController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40413F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 220,
                                child: Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: const Color(0xFF1F202B),
                                    fontSize: 24,
                                    fontFamily: GoogleFonts.pangolin().fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: 'male',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                    activeColor: const Color(0xFF56618A),
                                  ),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: GoogleFonts.pangolin().fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Radio<String>(
                                    value: 'female',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                    activeColor: const Color(0xFF56618A),
                                  ),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: GoogleFonts.pangolin().fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 43,
                  top: 805,
                  child: Checkbox(
                    value: agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF56618A),
                  ),
                ),
                Positioned(
                  left: 72,
                  top: 805,
                  child: SizedBox(
                    width: 312,
                    height: 40, // Ubah tinggi agar muat 2 baris
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: const Color(0xFFF7F7F7),
                          fontSize: 15,
                          fontFamily: GoogleFonts.pangolin().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'terms and conditions',
                            style: TextStyle(color: Color(0xFFF1E592)),
                          ),
                          TextSpan(text: ' as set out by the '),
                          TextSpan(
                            text: 'user agreement.',
                            style: TextStyle(color: Color(0xFFF1E592)),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.visible, // Agar teks tidak terpotong
                      softWrap: true,
                    ),
                  ),
                ),
                Positioned(
                  left: 29,
                  top: 859,
                  child: SizedBox(
                    width: 369,
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
                      onPressed: agreeTerms ? () {
                        // Validasi sederhana
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty ||
                            dobController.text.isEmpty ||
                            selectedGender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all the data!')),
                          );
                          return;
                        }
                        if (passwordController.text != confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password does not match!')),
                          );
                          return;
                        }
                        // Lakukan proses sign up di sini
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signed up successfully!')),
                        );
                      } : null,
                      child: const Text(
                        'Sign up',
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
                  left: 339,
                  top: 112,
                  child: Container(
                    width: 60,
                    height: 65,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/n-white.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
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
