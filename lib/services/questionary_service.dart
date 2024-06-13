import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/models/result.dart';

class QuestionaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchQuestionaries(
      String competence, String difficulty, String userRole) async {
    Query query = _firestore
        .collection('questionaries')
        .where('proficiency', isEqualTo: competence)
        .where('difficulty', isEqualTo: difficulty);

    // Filtrar solo cuestionarios activos para estudiantes
    if (userRole == 'student') {
      query = query.where('status', isEqualTo: 'Active');
    }

    QuerySnapshot querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) => {
              'id': doc.id,
              'name': doc['name'],
              'description': doc['description'],
              'time': doc['time'],
            })
        .toList();
  }

  Future<List<String>> fetchCompletedQuestionaries(String userId) async {
    QuerySnapshot studentQuery = await _firestore
        .collection('student')
        .where('userId', isEqualTo: userId)
        .get();

    if (studentQuery.docs.isNotEmpty) {
      var studentDoc = studentQuery.docs.first;
      String studentId = studentDoc.id;

      QuerySnapshot snapshot = await _firestore
          .collection('student')
          .doc(studentId)
          .collection('completedQuestionaries')
          .get();

      return snapshot.docs
          .map((doc) => doc['questionaryId'] as String)
          .toList();
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchQuestionaryDetails(
      String questionaryId) async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('questionaries').doc(questionaryId).get();

    return docSnapshot.data() as Map<String, dynamic>;
  }

  Future<void> updateQuestionaryField(
      String questionaryId, String field, String value) async {
    await _firestore
        .collection('questionaries')
        .doc(questionaryId)
        .update({field: value});
  }

  Future<String> getTeacherName(String teacherId) async {
    DocumentSnapshot teacherDoc =
        await _firestore.collection('teacher').doc(teacherId).get();
    String userId = teacherDoc['userId'];
    DocumentSnapshot userDoc =
        await _firestore.collection('user').doc(userId).get();
    return userDoc['name'];
  }

  Future<String?> getTeacherId(String userId) async {
    QuerySnapshot teacherQuery = await _firestore
        .collection('teacher')
        .where('userId', isEqualTo: userId)
        .get();

    if (teacherQuery.docs.isNotEmpty) {
      return teacherQuery.docs.first.id;
    } else {
      return null;
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

      String? teacherId = await getTeacherId(userId);

      if (teacherId == null) {
        return Result(
            success: false, message: "Error al obtener el ID del profesor.");
      }

      questionaryData['teacherId'] = teacherId;
      questionaryData['createdAt'] = Timestamp.now();
      questionaryData['status'] = "Active";

      await _firestore.collection('questionaries').add(questionaryData);
      return Result(success: true);
    } catch (e) {
      if (kDebugMode) {
        print("Error durante el registro del cuestionario: $e");
      }
      return Result(
          success: false,
          message: "Error durante el registro del cuestionario.");
    }
  }
}
