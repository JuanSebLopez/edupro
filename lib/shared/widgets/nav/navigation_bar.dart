import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Estadisticas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2),
          label: 'Perfil',
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
