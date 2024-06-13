import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'questionaries/questionary_list_screen.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  bool _isLoading = true;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _fetchQuestionaries();
  }

  Future<void> _fetchQuestionaries() async {
    setState(() {
      _isLoading = false;
    });
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
    });
  }

  Widget _buildCompetenceCard(String competence) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ExpansionTile(
        leading: Icon(Icons.book, color: Theme.of(context).primaryColor),
        title: Text(competence,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        children: <Widget>[
          ListTile(
            title: const Text('Fácil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionaryListScreen(
                    competence: competence,
                    difficulty: 'Fácil',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Intermedio'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionaryListScreen(
                    competence: competence,
                    difficulty: 'Intermedio',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Difícil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionaryListScreen(
                    competence: competence,
                    difficulty: 'Difícil',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final competences = [
      'Lectura Crítica',
      'Razonamiento Cuantitativo',
      'Competencias Ciudadanas',
      'Comunicación Escrita',
      'Inglés'
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10.0),
                Container(
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "¡Bienvenido,$_userName" "!",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: competences.map((competence) {
                          return _buildCompetenceCard(competence);
                        }).toList(),
                      ),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
