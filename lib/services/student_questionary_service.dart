import 'package:cloud_firestore/cloud_firestore.dart';

class StudentQuestionaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchCompletedQuestionary(
      String userId, String questionaryId) async {
    // Busca el documento del estudiante con el userId
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
          .where('questionaryId', isEqualTo: questionaryId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        throw Exception("No completed questionary found");
      }
    } else {
      throw Exception("No student found with userId $userId");
    }
  }

  Future<Map<String, dynamic>> fetchQuestionDetails(String questionId) async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('questionaries').doc(questionId).get();
    return docSnapshot.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> fetchQuestions(
      String questionaryId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('questionaries')
        .doc(questionaryId)
        .collection('questions')
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'question': doc['question'],
        'answers': List<String>.from(doc['answers']),
      };
    }).toList();
  }

  Future<int> submitAnswers(String userId, String questionaryId,
      List<Map<String, dynamic>> answers) async {
    // Busca el documento del estudiante con el userId
    QuerySnapshot studentQuery = await _firestore
        .collection('student')
        .where('userId', isEqualTo: userId)
        .get();

    if (studentQuery.docs.isNotEmpty) {
      var studentDoc = studentQuery.docs.first;
      String studentId = studentDoc.id;

      int score = 0;
      // Calcula la puntuación aquí

      await _firestore
          .collection('student')
          .doc(studentId)
          .collection('completedQuestionaries')
          .add({
        'questionaryId': questionaryId,
        'markedAnswers': answers,
        'score': score,
        'completedAt': Timestamp.now(),
      });

      return score;
    } else {
      throw Exception("No student found with userId $userId");
    }
  }
}
