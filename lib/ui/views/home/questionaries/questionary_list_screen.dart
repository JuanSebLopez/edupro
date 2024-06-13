import 'package:edupro/ui/views/home/questionaries/add_questionary_screen.dart';
import 'package:edupro/ui/views/home/questionaries/questionary_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/services/questionary_service.dart';

class QuestionaryListScreen extends StatefulWidget {
  final String competence;
  final String difficulty;

  const QuestionaryListScreen({
    required this.competence,
    required this.difficulty,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _QuestionaryListScreenState createState() => _QuestionaryListScreenState();
}

class _QuestionaryListScreenState extends State<QuestionaryListScreen> {
  final QuestionaryService _questionaryService = QuestionaryService();
  bool _isLoading = true;
  List<Map<String, dynamic>> _questionaries = [];
  String _userRole = '';
  String _userId = '';
  List<String> _completedQuestionaryIds = [];

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString('userRole') ?? 'student';
      _userId = prefs.getString('userId') ?? '';
    });
    await _fetchQuestionaries();
    if (_userRole == 'student') {
      await _fetchCompletedQuestionaries();
    }
  }

  Future<void> _fetchQuestionaries() async {
    List<Map<String, dynamic>> questionaries = await _questionaryService
        .fetchQuestionaries(widget.competence, widget.difficulty, _userRole);

    setState(() {
      _questionaries = questionaries;
      _isLoading = false;
    });
  }

  Future<void> _fetchCompletedQuestionaries() async {
    List<String> completedQuestionaries =
        await _questionaryService.fetchCompletedQuestionaries(_userId);
    setState(() {
      _completedQuestionaryIds = completedQuestionaries;
    });
  }

  Widget _buildQuestionaryCard(Map<String, dynamic> questionary) {
    bool isCompleted = _completedQuestionaryIds.contains(questionary['id']);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ListTile(
        title: Text(
          questionary['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(questionary['description'] ?? ''),
        trailing: Icon(
          _userRole == 'teacher'
              ? Icons.chevron_right
              : isCompleted
                  ? Icons.check_circle
                  : Icons.chevron_right,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionaryDetailsScreen(
                questionaryId: questionary['id'],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.competence),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _questionaries.length,
              itemBuilder: (context, index) {
                return _buildQuestionaryCard(_questionaries[index]);
              },
            ),
      floatingActionButton: _userRole == 'teacher'
          ? FloatingActionButton(
              onPressed: () {
                // Navegar a la pantalla de añadir cuestionario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddQuestionaryScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
