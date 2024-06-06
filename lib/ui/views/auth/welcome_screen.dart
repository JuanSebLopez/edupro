import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: Image.asset('background_home.png'),
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Edu',
                      style: GoogleFonts.loveYaLikeASister(
                        textStyle: const TextStyle(
                          fontSize: 64,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Pro',
                      style: GoogleFonts.loveYaLikeASister(
                        textStyle: const TextStyle(
                          fontSize: 64,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Encuentra las mejores pruebas para tu desempeño en las pruebas Sabre Pro.',
                style: GoogleFonts.loveYaLikeASister(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors
                        .black87, // Cambia el color del texto a un negro más oscuro
                    fontWeight: FontWeight.w500, // Agrega grosor al texto
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  Get.toNamed('/register');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(270, 51), // Tamaño del botón (w, h)
                  backgroundColor:
                      const Color(0xFF204F95), // Color de fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Radio de la esquina
                  ), // Tamaño mínimo del botón
                  shadowColor: Colors.black
                      .withOpacity(1), // Color y opacidad de la sombra
                  elevation: 5, // Altura de la sombra
                ),
                child: const Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    color: Colors.white, // Color blanco al texto
                    fontWeight: FontWeight.bold, // Agrega grosor al texto
                  ),
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
                      0, // Sin sombra, con esto el botón se vuelve de verdad transparente
                  shadowColor:
                      Colors.transparent, // Color de sombra transparente
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Color(0xFF204F95), // Color del texto
                    fontWeight: FontWeight.bold, // Agrega grosor al texto
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(
                4.0), // Ajusta el margen alrededor de la imagen
            child: Image.asset('app_logo.png'),
          ),
        ],
      ),
    );
  }
}
