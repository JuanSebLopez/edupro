import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/modules.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  final List<Color> _colors = [
    const Color(0xFF204F95), // Azul
    const Color(0xFF33B958), // Verde
    const Color(0xFF0C549C), // Azul oscuro
  ];
  int _colorIndex = 0;

  final List<bool> _isExpandedList = List.generate(15, (index) => false);

  Color _getNextColor() {
    final color = _colors[_colorIndex];
    _colorIndex = (_colorIndex + 1) % _colors.length;
    return color;
  }

  Color _getTextColor(Color backgroundColor) {
    // Verificar si el color de fondo es verde o azul oscuro
    if (backgroundColor == const Color(0xFF33B958) ||
        backgroundColor == const Color(0xFF0C549C)) {
      // Si el color de fondo es verde o azul oscuro, devolvemos un color negro
      return Colors.black;
    } else {
      // De lo contrario, devolvemos un color blanco para otros colores de fondo
      return Colors.white;
    }
  }

  Widget _buildModule(String title, int index) {
    final color = _getNextColor();
    final textColor = _getTextColor(color);

    return Padding(
      padding: EdgeInsets.only(
        top: _isExpandedList[index] ? 0.0 : 8.0,
        bottom: _isExpandedList[index] ? 8.0 : 0.0,
      ),
      child: ModuleCard(
        title: title,
        porcentage: '75%',
        color: color,
        width: 300,
        onExpand: () {
          setState(() {
            _isExpandedList[index] = !_isExpandedList[index];
          });
        },
        textColor: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(4.0),
                child: Image.asset('ImgHome2Png.png'),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildModule('Ingles', 0),
                    _buildModule('Español', 1),
                    _buildModule('Matematicas', 2),
                    _buildModule('Programación', 3),
                    _buildModule('Física', 4),
                    _buildModule('Sociales', 5),
                    _buildModule('Quimica', 6),
                    _buildModule('Biologia', 7),
                    _buildModule('Lectura critica', 8),
                    _buildModule('Geometria', 9),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
