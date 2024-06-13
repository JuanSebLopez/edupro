import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:edupro/services/questionary_service.dart';

class QuestionaryDetailsScreen extends StatefulWidget {
  final String questionaryId;

  const QuestionaryDetailsScreen({required this.questionaryId, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionaryDetailsScreenState createState() =>
      _QuestionaryDetailsScreenState();
}

class _QuestionaryDetailsScreenState extends State<QuestionaryDetailsScreen> {
  final QuestionaryService _questionaryService = QuestionaryService();
  Map<String, dynamic> _questionary = {};
  bool _isLoading = true;
  String _teacherName = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _fetchQuestionaryDetails();
  }

  Future<void> _fetchQuestionaryDetails() async {
    try {
      Map<String, dynamic> questionary = await _questionaryService
          .fetchQuestionaryDetails(widget.questionaryId);

      String teacherName =
          await _questionaryService.getTeacherName(questionary['teacherId']);

      setState(() {
        _questionary = questionary;
        _teacherName = teacherName;
        nameController.text = questionary['name'];
        descriptionController.text = questionary['description'];
        _selectedCompetence = questionary['proficiency'];
        _selectedDifficulty = questionary['difficulty'];
        statusController.text = questionary['status'];
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error:$e");
      }
      return;
    }
  }

  void _updateField(String field, String value) async {
    await _questionaryService.updateQuestionaryField(
      widget.questionaryId,
      field,
      value,
    );
    _fetchQuestionaryDetails();
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
                  _buildInfoRow('Status', _questionary['status']),
                  _buildInfoRow(
                      'Fecha',
                      _questionary['createdAt']
                          .toDate()
                          .toString()
                          .split(' ')[0]),
                  _buildDescriptionBox(_questionary['description']),
                  const SizedBox(height: 20),
                  _buildEditableField(
                    'Nombre',
                    nameController,
                    () => _updateField('name', nameController.text),
                  ),
                  const SizedBox(height: 10),
                  _buildDropdownField(
                    'Competencia',
                    _competences,
                    _selectedCompetence,
                    (newValue) {
                      setState(() {
                        _selectedCompetence = newValue;
                      });
                      _updateField('proficiency', newValue!);
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildDropdownField(
                    'Dificultad',
                    _difficulties,
                    _selectedDifficulty,
                    (newValue) {
                      setState(() {
                        _selectedDifficulty = newValue;
                      });
                      _updateField('difficulty', newValue!);
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(
                    'Descripción',
                    descriptionController,
                    () =>
                        _updateField('description', descriptionController.text),
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(
                    'Status',
                    statusController,
                    () => _updateField('status', statusController.text),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navegar a la pantalla de añadir pregunta
        },
        label: const Text('Añadir Pregunta'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
            child: Text('$label: $value',
                style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildDescriptionBox(String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(description),
    );
  }

  Widget _buildEditableField(
      String label, TextEditingController controller, VoidCallback onSave) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: onSave,
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? value,
      void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
