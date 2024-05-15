import 'package:edupro/models/questions.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _statementController = TextEditingController();
  final _answersController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  //String _correctAnswer = "";

  void _crearPregunta() {
    if (_formKey.currentState!.validate()) {
      final question = Question(
        subject: _subjectController.text,
        statement: _statementController.text,
        // Mapea todos los controles de respuestas
        answers:
            _answersController.map((controller) => controller.text).toList(),
      );
      // Limpiar controles
      //itsCorrect: _correctAnswer.isBool);
      _subjectController.clear();
      _statementController.clear();
      for (var controller in _answersController) {
        controller.clear();
      }
      // Limpia control de respeusta correcta
      //setState(() {
      //  _correctAnswer = "";
      //});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Pregunta"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: "Materia",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese una materia";
                  }
                  return null;
                },
              ),

              // Campo de enunciado
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _statementController,
                decoration: const InputDecoration(
                  labelText: "Enunciado",
                ),
                minLines: 3,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa un enunciado";
                  }
                  return null;
                },
              ),

              // Campos Respuestas
              const SizedBox(height: 20.0),
              for (int i = 0; i < _answersController.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Opcion ${i + 1}"),
                    TextFormField(
                      controller: _answersController[i],
                      decoration: InputDecoration(
                        hintText: "Respuesta ${i + 1}",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingresa una respuesta";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              // TODO: #1 La funcionalidad no esta completa, toca corregirla
              // Seleccion respuesta correcta
              //const SizedBox(height: 20.0),
              //DropdownButtonFormField<String>(
              //  value: _correctAnswer,
              //  hint: const Text(
              //      "Seleccione la respuesta correcta de la pregunta"),
              //  items: _answersController
              //      .map((controller) => DropdownMenuItem(
              //            value: controller.text,
              //            child: Text(controller.text),
              //          ))
              //      .toList(),
              //  onChanged: (value) {
              //    setState(() {
              //      _correctAnswer = value!;
              //    });
              //  },
              //  validator: (value) {
              //    if (value == null || value.isEmpty) {
              //      return "Seleccione la respuesta correcta";
              //    }
              //    return null;
              //  },
              //),

              // Boton para crear la pregunta
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _crearPregunta,
                child: const Text("Crear Pregunta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
