import 'package:edupro/models/result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/services/questionary_service.dart';

class AddQuestionaryScreen extends StatefulWidget {
  const AddQuestionaryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddQuestionaryScreenState createState() => _AddQuestionaryScreenState();
}

class _AddQuestionaryScreenState extends State<AddQuestionaryScreen> {
  final QuestionaryService _questionaryService = QuestionaryService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerAController = TextEditingController();
  final TextEditingController answerBController = TextEditingController();
  final TextEditingController answerCController = TextEditingController();

  String? _selectedCompetence;
  String? _selectedDifficulty;

  final List<String> _competences = [
    'Lectura Crítica',
    'Razonamiento Cuantitativo',
    'Competencias Ciudadanas',
    'Comunicación Escrita',
    'Inglés'
  ];

  final List<String> _difficulties = ['Fácil', 'Intermedio', 'Difícil'];

  void _addQuestionary() async {
    if (_selectedCompetence == null || _selectedDifficulty == null) {
      // Mostrar un mensaje de error si las competencias o dificultades no se han seleccionado
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Seleccione una competencia y una dificultad')),
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

    Map<String, dynamic> questionaryData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'proficiency': _selectedCompetence,
      'difficulty': _selectedDifficulty,
      'time': int.tryParse(timeController.text) ?? 0,
    };

    Result result = await _questionaryService.addQuestionary(questionaryData);

    if (mounted) {
      if (result.success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(result.message ?? 'Error al crear cuestionario')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar Cuestionario',
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
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del cuestionario',
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCompetence,
              decoration: const InputDecoration(
                labelText: 'Competencia a evaluar',
              ),
              items: _competences.map((String competence) {
                return DropdownMenuItem<String>(
                  value: competence,
                  child: Text(competence),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCompetence = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedDifficulty,
              decoration: const InputDecoration(
                labelText: 'Dificultad',
              ),
              items: _difficulties.map((String difficulty) {
                return DropdownMenuItem<String>(
                  value: difficulty,
                  child: Text(difficulty),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedDifficulty = newValue;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                labelText: 'Tiempo (min)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addQuestionary,
              child: const Text('Crear Cuestionario'),
            ),
          ],
        ),
      ),
    );
  }
}
