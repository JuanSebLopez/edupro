import 'package:flutter/material.dart';
import 'package:edupro/services/questionary_service.dart';
import 'package:edupro/models/result.dart';
import 'package:edupro/shared/widgets/warnings/warning_snackbar.dart';

class AddQuestionaryScreen extends StatefulWidget {
  const AddQuestionaryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddQuestionaryScreenState createState() => _AddQuestionaryScreenState();
}

class _AddQuestionaryScreenState extends State<AddQuestionaryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _difficultyController =
      TextEditingController(text: "0");
  String? _selectedCompetence;
  final _formKey = GlobalKey<FormState>();
  final QuestionaryService _questionaryService = QuestionaryService();

  void _addQuestionary() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Map<String, dynamic> questionaryData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'difficulty': double.parse(_difficultyController.text.trim()),
        'proficiency': _selectedCompetence,
      };

      Result result = await _questionaryService.addQuestionary(questionaryData);

      if (!mounted) return;

      if (result.success) {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      } else {
        WarningSnackbar.show(context, result.message ?? "Error desconocido.");
      }

      // Limpiar los campos de texto
      _nameController.clear();
      _descriptionController.clear();
      _difficultyController.text = "0";
      setState(() {
        _selectedCompetence = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Cuestionario"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nombre del Cuestionario",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Ingrese el nombre del cuestionario",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese el nombre del cuestionario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Descripción",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la descripción del cuestionario",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la descripción del cuestionario';
                  }
                  return null;
                },
              ),
              const Text(
                "Dificultad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        double value =
                            double.tryParse(_difficultyController.text) ?? 0;
                        if (value > 0) value -= 0.5;
                        _difficultyController.text = value.toString();
                      });
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _difficultyController,
                      decoration: const InputDecoration(
                        hintText: "Ingrese la dificultad",
                      ),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        double value =
                            double.tryParse(_difficultyController.text) ?? 0;
                        if (value < 10) value += 0.5;
                        _difficultyController.text = value.toString();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Competencia",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCompetence,
                onChanged: (value) {
                  setState(() {
                    _selectedCompetence = value;
                  });
                },
                items: [
                  "Lectura crítica",
                  "Razonamiento cuantitativo",
                  "Competencias ciudadanas",
                  "Comunicación escrita",
                  "Inglés"
                ]
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Seleccione una competencia";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 51),
                    backgroundColor: const Color(0xFF204F95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _addQuestionary,
                  child: const Text(
                    "Agregar Cuestionario",
                    style: TextStyle(fontFamily: 'Inter', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
