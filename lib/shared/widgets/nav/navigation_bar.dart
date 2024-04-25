import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

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
      currentIndex: currentRoute == '/homeScreen' ? 1 : 0,
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
}
