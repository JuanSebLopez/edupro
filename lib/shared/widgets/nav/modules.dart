import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final String title;
  final Color color;
  final String porcentage;
  final double width; // Nueva propiedad para el ancho

  const ModuleCard({
    super.key,
    required this.title,
    required this.color,
    required this.porcentage,
    required this.width, // Se añade el parámetro width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Usamos un SizedBox para controlar el ancho
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image.asset(imagePath), // Display the module image
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                porcentage,
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
