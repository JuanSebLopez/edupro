import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/services/student_questionary_service.dart';

class StudentQuestionaryTestScreen extends StatefulWidget {
  final String questionaryId;

  const StudentQuestionaryTestScreen({
    required this.questionaryId,
    super.key,
  });

  @override
  _StudentQuestionaryTestScreenState createState() =>
      _StudentQuestionaryTestScreenState();
}

class _StudentQuestionaryTestScreenState
    extends State<StudentQuestionaryTestScreen> {
  final StudentQuestionaryService _studentQuestionaryService =
      StudentQuestionaryService();
  List<Map<String, dynamic>> _questions = [];
  Map<String, String> _answers = {};
  bool _isLoading = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    if (_userId == null) return;

    List<Map<String, dynamic>> questions =
        await _studentQuestionaryService.fetchQuestions(widget.questionaryId);

    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  void _submitAnswers() async {
    if (_userId == null) return;

    List<Map<String, dynamic>> markedAnswers = _answers.entries.map((entry) {
      return {
        'questionId': entry.key,
        'markedAnswer': entry.value,
      };
    }).toList();

    int score = await _studentQuestionaryService.submitAnswers(
      _userId!,
      widget.questionaryId,
      markedAnswers,
    );

    Navigator.pop(context, score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Realizar Prueba',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF204F95),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ..._questions.map((question) {
                    return _buildQuestionCard(question);
                  }).toList(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitAnswers,
                    child: const Text('Finalizar Prueba'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(4, (index) {
                String option = String.fromCharCode(65 + index);
                return RadioListTile<String>(
                  title: Text(question['answers'][index]),
                  value: option,
                  groupValue: _answers[question['id']],
                  onChanged: (value) {
                    setState(() {
                      _answers[question['id']] = value!;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
