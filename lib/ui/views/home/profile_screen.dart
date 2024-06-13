import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/statistics_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:edupro/shared/widgets/nav/profile_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _username = '';
  String _userProfile = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
      _username = prefs.getString('username') ?? 'Sin nombre de usuario';
      _userProfile = prefs.getString('userProfile') ?? 'Sin descripcion';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, // Color de la flecha de retroceso
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white, // Color del icono de configuración
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text(
              _userName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              _username,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Estudiante',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            Text(
              _userProfile,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: StatisticsCard(
                    title: 'Estadísticas',
                    icon: Icons.trending_up,
                    color: Colors.blue,
                    count: '10',
                  ),
                ),
                Expanded(
                  child: StatisticsCard(
                    title: 'Completados',
                    icon: Icons.done,
                    color: Colors.green,
                    count: '0',
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
                    color: Colors.orange,
                    count: '0',
                  ),
                ),
                Expanded(
                  child: StatisticsCard(
                    title: 'Ranking',
                    icon: Icons.leaderboard_outlined,
                    color: Colors.amber,
                    count: '0',
                  ),
                ),
              ],
            ),
            const SizedBox(
                height:
                    20.0), // Espacio entre las estadísticas y el nuevo contenido
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.error,
                    size: 48,
                    color: Colors.blue, // Cambio del color del icono a azul
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Necesitas mejorar tus estadísticas, prueba repasar los temas que se te hayan complicado y vuelve a intentarlo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}

// Widget _buildCard({
//   required String title,
//   required String description, // For AchievementCard and AboutMeCard
//   required String count, // For PersonalStatisticsCard
//   required Color color, // For PersonalStatisticsCard
// }) {
//   if (title == 'Logros') {
//     return AchievementCard(title: title, description: description);
//   } else if (title == 'Sobre mí') {
//     return AboutMeCard(description: description);
//   } else {
//     return PersonalStatisticsCard(title: title, count: count, color: color);
//   }
// }