import 'package:flutter/material.dart';

class ModuleCard extends StatefulWidget {
  final String title;
  final Color color; // Nuevo atributo para el color de fondo
  final String porcentage;
  final double width; // Nueva propiedad para el ancho

  const ModuleCard({
    super.key,
    required this.title,
    required this.color, // Actualizada la propiedad color
    required this.porcentage,
    required this.width, // Se añade el parámetro width
  });

  @override
  // ignore: library_private_types_in_public_api
  _ModuleCardState createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Usamos un SizedBox para controlar el ancho
      width: widget.width,
      child: Card(
        color: widget.color, // Establecer el color de fondo del Card
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image.asset(imagePath), // Display the module image
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color blanco para el título
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.porcentage,
                        style: const TextStyle(
                          fontWeight: FontWeight
                              .bold, // Asegura que el porcentaje sea visible
                          color:
                              Colors.white, // Color blanco para el porcentaje
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        icon: Icon(
                          _isExpanded ? Icons.remove : Icons.add,
                          color: Colors.white, // Color blanco para el icono
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (_isExpanded) ...[
                // Widget para los submódulos cuando está expandido
                const SizedBox(height: 10),
                const Text(
                  'Submódulo 1',
                  style: TextStyle(
                    color: Colors.white, // Color blanco para los submódulos
                  ),
                ),
                const Text(
                  'Submódulo 2',
                  style: TextStyle(
                    color: Colors.white, // Color blanco para los submódulos
                  ),
                ),
                const Text(
                  'Submódulo 3',
                  style: TextStyle(
                    color: Colors.white, // Color blanco para los submódulos
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
