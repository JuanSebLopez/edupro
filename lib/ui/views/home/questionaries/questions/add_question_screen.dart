import 'package:edupro/models/result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/services/questionary_service.dart';

class AddQuestionScreen extends StatefulWidget {
  final String questionaryId;

  const AddQuestionScreen({required this.questionaryId, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final QuestionaryService _questionaryService = QuestionaryService();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerAController = TextEditingController();
  final TextEditingController answerBController = TextEditingController();
  final TextEditingController answerCController = TextEditingController();
  final TextEditingController answerDController = TextEditingController();
  String? _correctAnswer;

  final List<String> _answersOptions = ['A', 'B', 'C', 'D'];

  void _addQuestion() async {
    if (_correctAnswer == null ||
        questionController.text.isEmpty ||
        answerAController.text.isEmpty ||
        answerBController.text.isEmpty ||
        answerCController.text.isEmpty ||
        answerDController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, complete todos los campos')),
        );
      }
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al obtener el ID del usuario')),
        );
      }
      return;
    }

    Map<String, dynamic> questionData = {
      'question': questionController.text,
      'answers': [
        answerAController.text,
        answerBController.text,
        answerCController.text,
        answerDController.text,
      ],
      'correctAnswer': _correctAnswer,
    };

    Result result = await _questionaryService.addQuestion(
        widget.questionaryId, questionData);

    if (mounted) {
      if (result.success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(result.message ?? 'Error al crear la pregunta')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Pregunta',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF204F95),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: 'Pregunta',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: answerAController,
              decoration: const InputDecoration(
                labelText: 'Respuesta A',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: answerBController,
              decoration: const InputDecoration(
                labelText: 'Respuesta B',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: answerCController,
              decoration: const InputDecoration(
                labelText: 'Respuesta C',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: answerDController,
              decoration: const InputDecoration(
                labelText: 'Respuesta D',
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _correctAnswer,
              decoration: const InputDecoration(
                labelText: 'Opción Correcta',
              ),
              items: _answersOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _correctAnswer = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuestion,
              child: const Text('Agregar Pregunta'),
            ),
          ],
        ),
      ),
    );
  }
}
