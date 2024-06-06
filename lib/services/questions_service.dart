import 'package:flutter/foundation.dart';
import 'package:edupro/models/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> registerQuestion(Map<String, dynamic> questionData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId == null) {
        return Result(
          success: false,
          message: "Error al obtener el ID del usuario.",
        );
      }

      questionData['userId'] = userId;

      await _firestore.collection('questions').add(questionData);
      return Result(success: true);
    } catch (e) {
      if (kDebugMode) {
        print("Error during question registration: $e");
      }
      return Result(
        success: false,
        message: "Error durante el registro de la pregunta.",
      );
    }
  }
}
