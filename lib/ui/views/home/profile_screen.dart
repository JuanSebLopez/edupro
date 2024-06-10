import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/statistics_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/profile_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
    });
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10.0),
            const Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('assets/images/michael.jpg'),
                ),
                SizedBox(height: 16.0),
              ],
            ),
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Estudiante',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: _buildCard(
                    title: 'Sobre mí',
                    description: 'Sin descripcion',
                    count: 'count',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: StatisticsCard(
                    title: 'Estadísticas',
                    icon: Icons.trending_up,
                    count: '1.863',
                    color: Colors.blue,
                    percentage: '+10.9%',
                  ),
                ),
                Expanded(
                  child: StatisticsCard(
                    title: 'Completados',
                    icon: Icons.done,
                    count: '1.863',
                    color: Colors.green,
                    percentage: '+10.9%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: StatisticsCard(
                    title: 'Desafíos',
                    icon: Icons.lightbulb,
                    count: '1.863',
                    color: Colors.orange,
                    percentage: '+10.9%',
                  ),
                ),
                Expanded(
                  child: StatisticsCard(
                    title: 'Experiencia',
                    icon: Icons.star_border,
                    count: '11.863',
                    color: Colors.amber,
                    percentage: '+10.9%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
          ],
        ),
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
