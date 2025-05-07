import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/controllers/auth_controller.dart';
import 'package:store_app/views/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String password;
  late String fullName;
  bool _isLoading = false;
  registerUser() async {
    setState(() {
      _isLoading = true;
    });
    await _authController
        .signUpUsers(
          context: context,
          fullName: fullName,
          email: email,
          password: password,
        )
        .whenComplete(() {
          _formKey.currentState!.reset();
          setState(() {
            _isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildFullNameField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 30),
                  _buildSignUpButton(),
                  const SizedBox(height: 20),
                  _buildLoginRedirect(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          "Create Your Account",
          style: GoogleFonts.lato(
            color: const Color(0xFF0d120E),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        Text(
          'To Explore the world exclusives',
          style: GoogleFonts.lato(color: const Color(0xFF0d120E), fontSize: 14),
        ),
        Image.asset('assets/images/Illustration.png', width: 200, height: 200),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      onChanged: (value) => email = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Enter your email' : null,
      decoration: _inputDecoration(
        label: 'Enter your email',
        iconPath: 'assets/icons/email.png',
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      onChanged: (value) => fullName = value,
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Enter your full name' : null,
      decoration: _inputDecoration(
        label: 'Enter your full name',
        iconPath: 'assets/icons/user.jpeg',
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      onChanged: (value) => password = value,
      obscureText: true,
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Enter your password' : null,
      decoration: _inputDecoration(
        label: 'Enter your password',
        iconPath: 'assets/icons/password.png',
        suffixIcon: const Icon(Icons.visibility),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String iconPath,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
      labelText: label,
      labelStyle: GoogleFonts.nunitoSans(fontSize: 14),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(iconPath, width: 20, height: 20),
      ),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildSignUpButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          print('📧 $email, 👤 $fullName, 🔐 $password');
          await registerUser();
        }
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
          ),
        ),
        child: Center(
          child:
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                    'Sign Up',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an Account?',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
          child: Text(
            ' Sign In',
            style: GoogleFonts.roboto(
              color: const Color(0xFF103DE5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
