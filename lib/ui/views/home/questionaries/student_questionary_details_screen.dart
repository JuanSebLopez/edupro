import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupro/ui/views/home/questionaries/questions/student_questionary_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/services/student_questionary_service.dart';
import 'package:edupro/services/questionary_service.dart';

class StudentQuestionaryDetailsScreen extends StatefulWidget {
  final String questionaryId;
  final bool isCompleted;

  const StudentQuestionaryDetailsScreen({
    required this.questionaryId,
    required this.isCompleted,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _StudentQuestionaryDetailsScreenState createState() =>
      _StudentQuestionaryDetailsScreenState();
}

class _StudentQuestionaryDetailsScreenState
    extends State<StudentQuestionaryDetailsScreen> {
  final StudentQuestionaryService _studentQuestionaryService =
      StudentQuestionaryService();
  final QuestionaryService _questionaryService = QuestionaryService();
  Map<String, dynamic> _questionary = {};
  List<Map<String, dynamic>> _markedAnswers = [];
  bool _isLoading = true;
  String _teacherName = '';
  String _completedAt = '';
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestionaryDetails();
  }

  Future<void> _fetchQuestionaryDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId == null) return;

    Map<String, dynamic> questionary =
        await _questionaryService.fetchQuestionaryDetails(widget.questionaryId);
    String teacherName =
        await _questionaryService.getTeacherName(questionary['teacherId']);
    if (widget.isCompleted) {
      Map<String, dynamic> completedQuestionary =
          await _studentQuestionaryService.fetchCompletedQuestionary(
              userId, widget.questionaryId);

      setState(() {
        _questionary = questionary;
        _teacherName = teacherName;
        _completedAt = (completedQuestionary['completedAt'] as Timestamp)
            .toDate()
            .toString();
        _markedAnswers = List<Map<String, dynamic>>.from(
            completedQuestionary['markedAnswers']);
        _score = completedQuestionary['score'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _questionary = questionary;
        _teacherName = teacherName;
        _score = 0;
        _isLoading = false;
      });
    }
  }

  Widget _buildAnswerRow(Map<String, dynamic> answer) {
    return FutureBuilder<Map<String, dynamic>>(
      future:
          _studentQuestionaryService.fetchQuestionDetails(answer['questionId']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(
              child: Text('Error al cargar detalles de la pregunta'));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No hay detalles disponibles'));
        }

        Map<String, dynamic> question = snapshot.data!;
        return ListTile(
          title: Text(question['question']),
          subtitle: Text('Tu respuesta: ${answer['markedAnswer']}'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading ? 'Cargando...' : _questionary['name'],
          style: const TextStyle(
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
                  _buildInfoRow('Profesor que lo creó', _teacherName),
                  _buildInfoRow(
                      'Fecha de creación',
                      _questionary['createdAt']
                          .toDate()
                          .toString()
                          .split(' ')[0]),
                  if (widget.isCompleted)
                    _buildInfoRow(
                        'Fecha de realización', _completedAt.split(' ')[0]),
                  _buildInfoRow('Puntaje', _score.toString()),
                  if (widget.isCompleted) const SizedBox(height: 20),
                  if (widget.isCompleted)
                    const Text(
                      'Respuestas marcadas:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  if (widget.isCompleted) const SizedBox(height: 10),
                  if (widget.isCompleted)
                    ..._markedAnswers
                        .map((answer) => _buildAnswerRow(answer))
                        .toList(),
                  if (!widget.isCompleted)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentQuestionaryTestScreen(
                              questionaryId: widget.questionaryId,
                            ),
                          ),
                        );
                      },
                      child: const Text('Iniciar Prueba'),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text('$label: $value',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
