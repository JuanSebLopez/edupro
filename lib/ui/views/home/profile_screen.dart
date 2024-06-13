import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
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
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: _buildCard(
                    title: 'Logros',
                    description: 'Sin logros obtenidos',
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
                    description: 'Sin descripcion',
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
