import 'package:edupro/models/auth_result.dart';
import 'package:edupro/services/auth_service.dart';
import 'package:edupro/shared/widgets/textfield.dart';
import 'package:edupro/shared/widgets/warnings/warning_snackbar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    AuthResult result = await _authService.signIn(email, password);

    if (!mounted) return;

    if (result.success) {
      Navigator.pushNamed(context, '/homeScreen');
    } else {
      WarningSnackbar.show(context, result.message ?? "Error desconocido.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log In",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: passwordController,
              labelText: 'Password',
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Forgot your password?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(270, 51),
                backgroundColor: const Color(0xFF204F95),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Not registered?",
                    ),
                    const SizedBox(width: 5.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        "Sign up here",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 190.0),
                Image.asset(
                  "app_logo.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
