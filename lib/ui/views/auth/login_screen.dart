import 'package:edupro/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Iniciar sesión",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextField(
              controller: emailController,
              labelText: 'Correo electrónico',
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: passwordController,
              labelText: 'Contraseña',
            ),
            const SizedBox(height: 20.0),
            const Text(
              "¿Olvidaste tu contraseña?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue, // Color azul para el texto
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
                Navigator.pushNamed(context, '/homeScreen');
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
                'Inicia Sesión',
                style: TextStyle(color: Colors.white), //Color blanco al texto
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "¿No estás registrado?",
                ),
                const SizedBox(width: 5.0),
                TextButton(
                  onPressed: () {
                    // Acción del botón "Regístrate aquí"
                    Get.toNamed('/register');
                  },
                  child: const Text(
                    "Regístrate aquí",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ), // Color azul para el texto del botón
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              "ImgHome2Png.png", // Ruta de la imagen
            ),
          ],
        ),
      ),
    );
  }
}
