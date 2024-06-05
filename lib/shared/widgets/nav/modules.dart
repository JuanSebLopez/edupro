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
    required this.width,
    required Null Function() onExpand,
    required Color textColor,
  });

  @override
  ModuleCardState createState() => ModuleCardState();
}

class ModuleCardState extends State<ModuleCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Color titleColor =
        widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return SizedBox(
      // Usamos un SizedBox para controlar el ancho
      width: widget.width,
      child: Card(
        color: widget.color, // Establecer el color de fondo del Card
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 16), // Ajuste del padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          titleColor, // Color del título basado en el color de fondo
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          _isExpanded ? Icons.remove_circle : Icons.add_circle,
                          color: Colors
                              .white, // Color del centro del icono igual al color de fondo del módulo
                          size: 20, // Tamaño del icono
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                // Widget para los submódulos cuando está expandido
                const SizedBox(height: 10.0),
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
