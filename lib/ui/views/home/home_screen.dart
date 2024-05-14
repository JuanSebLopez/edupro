// main.dart
import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/modules.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  final List<Color> _colors = [
    const Color(0xFF204F95), // Azul
    const Color(0xFF33B958), // Verde
    const Color(0xFF0C549C), // Azul oscuro
  ];
  int _colorIndex = 0;

  Color _getNextColor() {
    final color = _colors[_colorIndex];
    _colorIndex = (_colorIndex + 1) % _colors.length;
    return color;
  }

  Widget _buildModule(String title) {
    return ModuleCard(
      title: title,
      porcentage: '100%',
      color: _getNextColor(),
      width: 300,
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
                    _buildModule('Ingles'),
                    _buildModule('Español'),
                    _buildModule('Matematicas'),
                    _buildModule('Programación'),
                    _buildModule('Física'),
                    _buildModule('Sociales'),
                    _buildModule('Quimica'),
                    _buildModule('Biologia'),
                    _buildModule('Lectura critica'),
                    _buildModule('Geometria'),
                    _buildModule('Algebra'),
                    _buildModule('Calculo'),
                    _buildModule('Estadistica'),
                    _buildModule('Catedra'),
                    _buildModule('Etica'),
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
