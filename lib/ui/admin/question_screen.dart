import 'package:edupro/models/questions.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 =
      TextEditingController(); // Nuevo controlador para la respuesta D

  String? _selectedSubject;
  String? _selectedCorrectAnswer;

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "A que materia pertenece la pregunta:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedSubject,
                    onChanged: (value) {
                      setState(() {
                        _selectedSubject = value;
                      });
                    },
                    items:
                        ["Inglés", "Matemáticas", "Lectura Crítica", "Biología"]
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
                        return "Selecciona el tema de la pregunta";
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
                    child: TextField(
                      controller: _controller1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
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
                                child: TextField(
                                  controller: i == 0
                                      ? _controller2
                                      : i == 1
                                          ? _controller3
                                          : i == 2
                                              ? _controller4
                                              : _controller5, // Asignar el nuevo controlador para la respuesta D
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    border: InputBorder.none,
                                  ),
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
                      if (value == null || value.isEmpty) {
                        return "Selecciona la respuesta correcta";
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
                    onPressed: () {
                      // Capturar los valores de los campos de texto y la selección del menú desplegable
                      String? subject = _selectedSubject;
                      String question = _controller1.text;
                      String answerA = _controller2.text;
                      String answerB = _controller3.text;
                      String answerC = _controller4.text;
                      String answerD = _controller5
                          .text; // Capturar el texto de la respuesta D
                      String correctAnswer = _selectedCorrectAnswer ?? '';

                      // Validar que todos los campos estén llenos antes de agregar la pregunta
                      if (subject != null &&
                          question.isNotEmpty &&
                          answerA.isNotEmpty &&
                          answerB.isNotEmpty &&
                          answerC.isNotEmpty &&
                          answerD
                              .isNotEmpty && // Agregar la validación para la respuesta D
                          correctAnswer.isNotEmpty) {
                        // Agregar la pregunta a la lista questions
                        questions.add({
                          'subject': subject,
                          'question': question,
                          'answers': [
                            answerA,
                            answerB,
                            answerC,
                            answerD
                          ], // Agregar la respuesta D
                          'correctAnswer': correctAnswer,
                        });

                        // Mostrar la información de la pregunta por consola
                        print("Nueva pregunta registrada:");
                        print("Materia: $subject");
                        print("Pregunta: $question");
                        print(
                            "Respuestas: $answerA, $answerB, $answerC, $answerD");
                        print("Respuesta correcta: $correctAnswer");

                        // Mostrar mensaje de éxito
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pregunta registrada con éxito'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Registrar pregunta",
                      style:
                          TextStyle(fontFamily: 'Inter', color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
