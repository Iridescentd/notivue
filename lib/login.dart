import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'utils/constants.dart';
import 'dart:developer' as developer;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _resendConfirmationEmail() async {
    try {
      await supabase.auth.resend(
        type: OtpType.signup,
        email: _emailController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Confirmation email has been resent. Please check your inbox.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Error resending confirmation email: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      } else {
        setState(() {
          _errorMessage = 'Login failed: No user data returned.';
        });
      }
    } on AuthException catch (e) {
      developer.log('Login Auth error:', error: e);
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      developer.log('Login general error:', error: e);
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF56618A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'welcome back!',
                            style: GoogleFonts.righteous(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'time to pick up where you left off.',
                            style: GoogleFonts.pangolin(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 60,
                      height: 65,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/n-white.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 35.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0D7FF),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Email',
                        style: GoogleFonts.pangolin(
                          color: const Color(0xFF1F202B),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.pangolin(fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your email',
                          hintStyle:
                              GoogleFonts.pangolin(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Password',
                        style: GoogleFonts.pangolin(
                          color: const Color(0xFF1F202B),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: GoogleFonts.pangolin(fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your password',
                          hintStyle:
                              GoogleFonts.pangolin(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: const Color(0xFF56618A),
                            checkColor: Colors.white,
                            side: BorderSide(color: Colors.grey[600]!),
                          ),
                          Text(
                            'Remember me on this device',
                            style: GoogleFonts.pangolin(
                              color: const Color(0xFF1F202B),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 5.0),
                          child: Text(
                            _errorMessage!,
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1E592),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF56618A)),
                        )
                      : Text(
                          'Log in',
                          style: GoogleFonts.righteous(
                              color: const Color(0xFF1F202B),
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.pangolin(
                          color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.pangolin(
                          color: const Color(0xFFF1E592),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFFF1E592),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
