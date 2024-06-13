import 'package:edupro/models/result.dart';
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
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _signIn() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String identifier = identifierController.text;
      String password = passwordController.text;

      Result result = await _authService.signIn(identifier, password);

      if (!mounted) return;

      if (result.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homeScreen', (route) => false);
      } else {
        WarningSnackbar.show(context, result.message ?? "Error desconocido.");
      }
    }
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo o nombre de usuario';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su contraseña';
    } else if (value.length < 8 || value.length > 100) {
      return 'La contraseña es incorrecta o no es válida';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inicio de Sesión",
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTextField(
                  controller: identifierController,
                  labelText: 'Correo Electrónico o Nombre de Usuario',
                  validator: _validateIdentifier,
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: passwordController,
                  labelText: 'Contraseña',
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "¿Olvidé mi contraseña?",
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
                    'Iniciar Sesión',
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
                          "¿No tienes cuenta?",
                        ),
                        const SizedBox(width: 5.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            "Crear Cuenta",
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
                      "assets/images/app_logo.png",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
