import 'package:flutter/material.dart';
import 'package:edupro/models/result.dart';
import 'package:edupro/services/questions_service.dart';
import '../../shared/widgets/warnings/warning_snackbar.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerAController = TextEditingController();
  final TextEditingController _answerBController = TextEditingController();
  final TextEditingController _answerCController = TextEditingController();
  final TextEditingController _answerDController = TextEditingController();
  final QuestionService _questionService = QuestionService();
  final _formKey = GlobalKey<FormState>();
  String? _selectedCompetence;
  String? _selectedCorrectAnswer;

  void _registerQuestion() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Map<String, dynamic> questionData = {
        'competence': _selectedCompetence,
        'question': _questionController.text.trim(),
        'answers': [
          _answerAController.text.trim(),
          _answerBController.text.trim(),
          _answerCController.text.trim(),
          _answerDController.text.trim(),
        ],
        'correctAnswer': _selectedCorrectAnswer,
      };

      Result result = await _questionService.registerQuestion(questionData);

      if (!mounted) return;

      if (result.success) {
        // Limpiar los campos de texto
        _questionController.clear();
        _answerAController.clear();
        _answerBController.clear();
        _answerCController.clear();
        _answerDController.clear();
        setState(() {
          _selectedCompetence = null;
          _selectedCorrectAnswer = null;
        });
        Navigator.pushReplacementNamed(context, '/homeScreen');
      } else {
        WarningSnackbar.show(context, result.message ?? "Error desconocido.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF204F95),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: AppBar(
            backgroundColor: const Color(0xFF204F95),
            elevation: 0,
            title: const Text(
              "Registro de preguntas",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Seleccione una competencia:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedCompetence,
                  onChanged: (value) {
                    setState(() {
                      _selectedCompetence = value;
                    });
                  },
                  items: [
                    "Lectura Crítica",
                    "Razonamiento Cuantitativo",
                    "Competencias Ciudadanas",
                    "Comunicación Escrita",
                    "Inglés"
                  ]
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Seleccione una competencia";
                    }
                    return null;
                  },
                ),
              ),
              const Text(
                "Enunciado de la pregunta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: _questionController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        maxLength: 500,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese el enunciado de la pregunta';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Respuesta ${String.fromCharCode(65 + i)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: TextFormField(
                                controller: i == 0
                                    ? _answerAController
                                    : i == 1
                                        ? _answerBController
                                        : i == 2
                                            ? _answerCController
                                            : _answerDController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese una respuesta';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12.0),
              const Text(
                "Respuesta correcta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedCorrectAnswer,
                  onChanged: (value) {
                    setState(() {
                      _selectedCorrectAnswer = value;
                    });
                  },
                  items: ["A", "B", "C", "D"]
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Seleccione la respuesta correcta";
                    }
                    return null;
                  },
                ),
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
                  onPressed: _registerQuestion,
                  child: const Text(
                    "Registrar pregunta",
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
