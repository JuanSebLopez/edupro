import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ocultar la barra de AppBar
        automaticallyImplyLeading: false,
        elevation: 0, // Quitar la sombra de la AppBar
        backgroundColor: Colors.transparent, // Hacer transparente la AppBar
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          // Profile picture and name section
          const Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('michael7.jpg'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Juan David Peralta Fuentes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Estudiante',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200, // Ajusta el ancho según tus necesidades
                child: _buildCard(
                  title: 'Logros',
                  description: 'description',
                  count: 'count',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200, // Ajusta el ancho según tus necesidades
                child: _buildCard(
                  title: 'Sobre mí',
                  description: 'description',
                  count: 'count',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          const SizedBox(height: 24.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     _buildCard(
          //       title: 'Estadisticas Personales',
          //       description: 'description',
          //       count: 'count',
          //       color: Colors.blue,
          //     ),
          //   ],
          // ),
        ],
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}

Widget _buildCard({
  required String title,
  required String description, // For AchievementCard and AboutMeCard
  required String count, // For PersonalStatisticsCard
  required Color color, // For PersonalStatisticsCard
}) {
  if (title == 'Logros') {
    return AchievementCard(title: title, description: description);
  } else if (title == 'Sobre mí') {
    return AboutMeCard(description: description);
  } else {
    return PersonalStatisticsCard(title: title, count: count, color: color);
  }
}
