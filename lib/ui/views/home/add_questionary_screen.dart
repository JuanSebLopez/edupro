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
    var _selectedDifficulty;
    var _valueController;

    var _questionController;
    var _responseAController;
    var _responseBController;
    var _responseCController;
    var _responseDController;

    var _selectedCorrectOption;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agregar Cuestionario",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800, // Extra bold
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Color del icono de regreso
          size: 24.0, // Tamaño del icono de regreso
        ),
        backgroundColor: const Color(0xFF204F95), // Fondo color
        elevation: 10.0, // Borde inferior de 10px
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Temática a evaluar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la temática del cuestionario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la temática del cuestionario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Competencia a evaluar",
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
              const SizedBox(height: 12.0),
              const Text(
                "Dificultad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                },
                items: ["Fácil", "Medio", "Difícil"]
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
                    return "Seleccione una dificultad";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Valor del cuestionario",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                  hintText: "Ingrese el valor del cuestionario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese el valor del cuestionario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Pregunta",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la pregunta",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la pregunta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Respuesta A",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _responseAController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la respuesta A",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la respuesta A';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Respuesta B",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _responseBController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la respuesta B",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la respuesta B';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Respuesta C",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _responseCController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la respuesta C",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la respuesta C';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Respuesta D",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _responseDController,
                decoration: const InputDecoration(
                  hintText: "Ingrese la respuesta D",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingrese la respuesta D';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Opción Correcta",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCorrectOption,
                onChanged: (value) {
                  setState(() {
                    _selectedCorrectOption = value;
                  });
                },
                items: ["A", "B", "C", "D"]
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
                    return "Seleccione una opción correcta";
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
