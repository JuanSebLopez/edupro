import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/profile_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
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
                  width: 300,
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
                  width: 300,
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
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}

Widget _buildCard({
  required String title,
  required String description,
  required String count,
  required Color color,
}) {
  if (title == 'Logros') {
    return AchievementCard(title: title, description: description);
  } else if (title == 'Sobre mí') {
    return AboutMeCard(description: description);
  } else {
    return PersonalStatisticsCard(title: title, count: count, color: color);
  }
}
