import 'package:edupro/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

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
          icon: const Icon(Icons.arrow_back), // Icono de flecha hacia atrás
          onPressed: () {
            Navigator.of(context).pop(); // Regresar a la vista anterior
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
              onPressed: () {
                // Acción del botón
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(270, 51), //Tamaño del boton (w, h)
                backgroundColor:
                    const Color(0xFF204F95), // Color de fondo del botón
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Radio de la esquina
                ), // Tamaño mínimo del botón
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(color: Colors.white), //Color blanco al texto
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
                // Acción del botón
                Get.toNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Color de fondo transparente
                elevation:
                    0, // Sin sombra, con esto el boton se vuelve de verdad transparente
                shadowColor: Colors.transparent, // Color de sombra transparente
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Color(0xFF204F95),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0, // Color del texto
                ),
              ),
            )
          ],
        ),
      ),
    );
    //throw UnimplementedError();
  }
}