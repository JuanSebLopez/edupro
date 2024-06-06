import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFEFEFEF), // Color de fondo personalizado
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up,
              color: Color(0xFF0C549C)), // Color del icono personalizado
          label: 'Estatistics', // Etiqueta vacía
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: Color(0xFF0C549C)), // Color del icono personalizado
          label: 'Home', // Etiqueta vacía
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: Color(0xFF0C549C)), // Color del icono personalizado
          label: 'Profile', // Etiqueta vacía
        ),
      ],
      currentIndex: _getCurrentIndex(currentRoute),
      onTap: (int index) {
        // Handle navigation to the selected page
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/statistics');
            break;
          case 1:
            Navigator.pushNamed(context, '/homeScreen');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }

  int _getCurrentIndex(String? currentRoute) {
    if (currentRoute == '/statistics') {
      return 0;
    } else if (currentRoute == '/homeScreen') {
      return 1;
    } else {
      return 2;
    }
  }
}
