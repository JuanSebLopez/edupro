import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/models/result.dart';

class QuestionaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchQuestionaries() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('questionary').get();
      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'name': doc['name'],
                'description': doc['description'],
                'proficiency': doc['proficiency'],
                'userId': doc['userId'],
                'difficulty': doc['difficulty'],
                'createdAt': doc['createdAt']
                // Añadir otros campos aquí si es necesario
              })
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchQuestions(
      String questionaryId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('questions')
          .where('questionaryId', isEqualTo: questionaryId)
          .get();
      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'question': doc['question'],
                'answers': doc['answers'],
                'correctAnswer': doc['correctAnswer'],
                'competence': doc['competence'],
                'userId': doc['userId'],
                'status': doc['status'],
                'createdAt': doc['createdAt'],
                // Añadir otros campos aquí si es necesario
              })
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Result> addQuestionary(Map<String, dynamic> questionaryData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId == null) {
        return Result(
            success: false, message: "Error al obtener el ID del usuario.");
      }

      questionaryData['userId'] = userId;
      questionaryData['createdAt'] = DateTime.now().toUtc().toString();
      questionaryData['status'] = "Activo";

      await _firestore.collection('questionary').add(questionaryData);
      return Result(success: true);
    } catch (e) {
      if (kDebugMode) {
        print("Error during questionary addition: $e");
      }
      return Result(
          success: false,
          message: "Error durante el registro del cuestionario.");
    }
  }
}
