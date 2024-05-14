import 'package:edupro/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Lista simulada de usuarios registrados (podría ser reemplazada por una base de datos real)
  final List<Map<String, String>> registeredUsers = [
    {
      'email': 'user1@example.com',
      'password': 'password1',
    },
    {
      'email': 'user2@example.com',
      'password': 'password2',
    },
    // Añade más usuarios según sea necesario
  ];

  void _signIn() {
    String email = emailController.text;
    String password = passwordController.text;

    // Verificar si el usuario existe y las credenciales son válidas
    bool isValidUser = registeredUsers
        .any((user) => user['email'] == email && user['password'] == password);

    if (isValidUser) {
      // Si las credenciales son válidas, redirige al usuario a la pantalla de inicio
      Navigator.pushNamed(context, '/homeScreen');
    } else {
      // Si las credenciales no son válidas, muestra un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email o Password inválido"),
            content: Text("Por favor, revisa tus credenciales."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
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
                  "ImgHome2Png.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
