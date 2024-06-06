import 'package:flutter/material.dart';
import 'package:edupro/services/questionary_service.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'add_questionary_screen.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  final QuestionaryService _questionaryService = QuestionaryService();
  Map<String, List<Map<String, dynamic>>> _competenceQuestionaries = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestionaries();
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
      _competenceQuestionaries = competenceQuestionaries;
      _isLoading = false;
    });
  }

  Widget _buildCompetenceCard(
      String competence, List<Map<String, dynamic>> questionaries) {
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
        children: questionaries.map((questionary) {
          return ListTile(
            title: Text(questionary['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionaryDetailScreen(
                    questionaryId: questionary['id'],
                    questionaryName: questionary['name'],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  "¡Bienvenido, Usuario!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children:
                            _competenceQuestionaries.keys.map((competence) {
                          final questionaries =
                              _competenceQuestionaries[competence]!;
                          return _buildCompetenceCard(
                              competence, questionaries);
                        }).toList(),
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
                      builder: (context) => const AddQuestionaryScreen()),
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
