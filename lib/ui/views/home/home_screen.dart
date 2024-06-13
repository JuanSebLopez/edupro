import 'package:flutter/material.dart';
import 'package:edupro/services/questionary_service.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_questionary_screen.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  final QuestionaryService _questionaryService = QuestionaryService();
  // Map<String, List<Map<String, dynamic>>> _competenceQuestionaries = {};
  bool _isLoading = true;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _fetchQuestionaries();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
    });
  }

  Future<void> _fetchQuestionaries() async {
    List<Map<String, dynamic>> questionaries =
        await _questionaryService.fetchQuestionaries();
    Map<String, List<Map<String, dynamic>>> competenceQuestionaries = {};

    for (var questionary in questionaries) {
      final competence = questionary['proficiency'];
      if (!competenceQuestionaries.containsKey(competence)) {
        competenceQuestionaries[competence] = [];
      }
      competenceQuestionaries[competence]!.add(questionary);
    }

    setState(() {
      // _competenceQuestionaries = competenceQuestionaries;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.all(4.0),
                        child: Image.asset('assets/images/app_logo.png'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "¡Bienvenido, $_userName" "!",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: _buildCompetenceCards(),
                      ),
                const SizedBox(height: 80.0), // Espacio adicional para el FAB
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddQuestionaryScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}

List<Widget> _buildCompetenceCards() {
  final List<String> titles = [
    'Lectura Critica',
    'Razonamiento Cuantitativo',
    'Competencias Ciudadanas',
    'Comunicación Escrita',
    'Inglés'
  ];

  return List<Widget>.generate(titles.length, (index) {
    return CompetenceCard(
      title: titles[index],
      isEven: index % 2 == 0,
    );
  });
}

class CompetenceCard extends StatefulWidget {
  final String title;
  final bool isEven;

  const CompetenceCard({super.key, required this.title, required this.isEven});

  @override
  // ignore: library_private_types_in_public_api
  _CompetenceCardState createState() => _CompetenceCardState();
}

class _CompetenceCardState extends State<CompetenceCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cardColor =
        widget.isEven ? const Color(0xFF0C549C) : const Color(0xFF33B958);

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: Icon(
          _isExpanded ? Icons.remove : Icons.add,
          color: Colors.white,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: <Widget>[
          ListTile(
            title: const Text('Fácil', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al seleccionar la opción Fácil
            },
          ),
          ListTile(
            title: const Text('Medio', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al seleccionar la opción Medio
            },
          ),
          ListTile(
            title: const Text('Difícil', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al seleccionar la opción Difícil
            },
          ),
        ],
      ),
    );
  }
}

class QuestionaryDetailScreen extends StatelessWidget {
  final String questionaryId;
  final String questionaryName;

  const QuestionaryDetailScreen(
      {required this.questionaryId, required this.questionaryName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(questionaryName),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: QuestionaryService().fetchQuestions(questionaryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar preguntas'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay preguntas disponibles'));
          }

          final questions = snapshot.data!;
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return ListTile(
                title: Text(question['question']),
                subtitle: Text('Competencia: ${question['competence']}'),
                onTap: () {
                  // Acción al hacer clic en una pregunta
                },
              );
            },
          );
        },
      ),
    );
  }
}
