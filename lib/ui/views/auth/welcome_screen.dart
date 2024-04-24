import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(
                4.0), // Ajusta el margen alrededor de la imagen
            child: Image.asset('ImgHome1Png.png'),
          ),
          Column(
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Edu',
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.blue, // Color para la parte "Edu"
                      ),
                    ),
                    TextSpan(
                      text: 'Pro',
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.green, // Color para la parte "Pro"
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Espacio entre los elementos
              const Text(
                'Encuentra los mejores cuestionarios para tu desempeño en las pruebas saber Pro.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  Get.toNamed('/register');
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
                  'Regístrate',
                  style: TextStyle(color: Colors.white), //Color blanco al texto
                ),
              ),
              const SizedBox(height: 10),
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
                  shadowColor:
                      Colors.transparent, // Color de sombra transparente
                ),
                child: const Text(
                  'Inicia sesión',
                  style: TextStyle(
                    color: Color(0xFF204F95), // Color del texto
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(
                4.0), // Ajusta el margen alrededor de la imagen
            child: Image.asset('ImgHome2Png.png'),
          ),
        ],
      ),
    );
  }
}
