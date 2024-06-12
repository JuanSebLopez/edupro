import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionaryDetailScreen extends StatefulWidget {
  final String questionaryId;
  final String questionaryName;

  const QuestionaryDetailScreen({
    required this.questionaryId,
    required this.questionaryName,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _QuestionaryDetailScreenState createState() =>
      _QuestionaryDetailScreenState();
}

class _QuestionaryDetailScreenState extends State<QuestionaryDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _questionaryData;
  bool _isLoading = true;
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchQuestionaryDetails();
  }

  Future<void> _fetchQuestionaryDetails() async {
    DocumentSnapshot doc = await _firestore
        .collection('questionary')
        .doc(widget.questionaryId)
        .get();
    if (doc.exists) {
      setState(() {
        _questionaryData = doc.data() as Map<String, dynamic>;
        _nameController.text = _questionaryData!['name'];
        _descriptionController.text = _questionaryData!['description'];
        _difficultyController.text = _questionaryData!['difficulty'].toString();
        _timeController.text = _questionaryData!['time'].toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.questionaryName),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                // Save functionality here
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField("Nombre", _nameController, readOnly: !_isEditing),
            _buildTextField("Descripción", _descriptionController,
                readOnly: !_isEditing),
            _buildTextField("Dificultad", _difficultyController,
                readOnly: !_isEditing),
            _buildTextField("Tiempo (min)", _timeController,
                readOnly: !_isEditing),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: Text(_isEditing ? "Cancelar" : "Editar"),
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Realizar Cuestionario"),
                  onPressed: () {
                    // Acción para realizar el cuestionario
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
