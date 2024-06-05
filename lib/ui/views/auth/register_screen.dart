import 'package:edupro/models/auth_result.dart';
import 'package:edupro/services/auth_service.dart';
import 'package:edupro/shared/widgets/textfield.dart';
import 'package:edupro/shared/widgets/warnings/warning_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final typeIdController = TextEditingController();
  final idController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  void _registerUser() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text,
        'typeId': typeIdController.text,
        'id': idController.text,
      };

      AuthResult result = await _authService.registerUser(userData);

      if (!mounted) return;

      if (result.success) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Registro exitoso"),
              content:
                  const Text("El usuario ha sido registrado exitosamente."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );

        // Limpiar los campos de texto
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneNumberController.clear();
        typeIdController.clear();
        idController.clear();
      } else {
        WarningSnackbar.show(context, result.message ?? "Error desconocido.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: nameController,
              labelText: "Full name",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: emailController,
              labelText: "Institutional mail",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: passwordController,
              labelText: "Password",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: phoneNumberController,
              labelText: "Phone number",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: typeIdController,
              labelText: "Type of document",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: idController,
              labelText: "No. Id",
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _registerUser,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(270, 51),
                backgroundColor: const Color(0xFF204F95),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Already registered?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Color(0xFF204F95),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
