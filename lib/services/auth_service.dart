import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/models/result.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> signIn(String email, String password) async {
    try {
      QuerySnapshot emailQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        var userDoc = emailQuery.docs.first;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userDoc.id);
        await prefs.setString('userEmail', userDoc['email']);
        await prefs.setString('userName', userDoc['name']);
        return Result(success: true);
      } else {
        return Result(
          success: false,
          message: "Email o contraseña incorrectos.",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign in: $e");
      }
      return Result(
        success: false,
        message: "Error durante el inicio de sesión.",
      );
    }
  }

  Future<Result> registerUser(Map<String, dynamic> userData) async {
    try {
      QuerySnapshot emailQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: userData['email'])
          .get();

      QuerySnapshot idQuery = await _firestore
          .collection('users')
          .where('id', isEqualTo: userData['id'])
          .get();

      QuerySnapshot phoneQuery = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: userData['phoneNumber'])
          .get();

      if (emailQuery.docs.isNotEmpty) {
        return Result(
          success: false,
          message: "El correo electrónico digitado ya se encuentra registrado.",
        );
      } else if (idQuery.docs.isNotEmpty) {
        return Result(
          success: false,
          message: "Esta Persona ya se encuentra registrada con una cuenta.",
        );
      } else if (phoneQuery.docs.isNotEmpty) {
        return Result(
          success: false,
          message:
              "El número de teléfono ya se encuentra registrada con una cuenta.",
        );
      } else {
        await _firestore.collection('users').add(userData);
        return Result(success: true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during registration: $e");
      }
      return Result(
        success: false,
        message: "Error durante el registro.",
      );
    }
  }
}
