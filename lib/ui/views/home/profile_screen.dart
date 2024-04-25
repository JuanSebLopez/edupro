import 'package:edupro/shared/widgets/nav/profile_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
              // ... Navigate to settings page or perform other actions
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Profile picture and name section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          AssetImage('assets/images/profile_picture.jpg'),
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Nombre Apellido',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Estudiante',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildCard(
                      title: 'Logros',
                      description: 'description',
                      count: 'count',
                      color: Colors.blue),
                  const SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildCard(
                      title: 'Sobre mí',
                      description: 'description',
                      count: 'count',
                      color: Colors.blue),
                  const SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildCard(
                      title: 'Estadisticas Personales',
                      description: 'description',
                      count: 'count',
                      color: Colors.blue),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
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
