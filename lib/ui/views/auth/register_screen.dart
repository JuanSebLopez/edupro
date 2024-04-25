import 'package:edupro/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final typeId = TextEditingController();
  final id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            CustomTextField(
              controller: name,
              labelText: "Nombre completo",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: email,
              labelText: "Correo institucional",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: password,
              labelText: "Contraseña",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: phoneNumber,
              labelText: "Número de telefono",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: typeId,
              labelText: "Tipo de documento",
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: id,
              labelText: "No. de documento",
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
                'Regístrarse',
                style: TextStyle(color: Colors.white), //Color blanco al texto
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '¿Ya tienes una cuenta?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Color de fondo transparente
                elevation:
                    0, // Sin sombra, con esto el boton se vuelve de verdad transparente
                shadowColor: Colors.transparent, // Color de sombra transparente
              ),
              child: const Text(
                'Inicia sesión',
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
