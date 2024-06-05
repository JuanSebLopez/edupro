import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/models/auth_result.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AuthResult> signIn(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userDoc.id);
        await prefs.setString('userEmail', userDoc['email']);
        await prefs.setString('userName', userDoc['name']);
        return AuthResult(success: true);
      } else {
        return AuthResult(
          success: false,
          message: "Email o contraseña incorrectos.",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign in: $e");
      }
      return AuthResult(
        success: false,
        message: "Error durante el inicio de sesión.",
      );
    }
  }

  Future<AuthResult> registerUser(Map<String, dynamic> userData) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: userData['email'])
          .get();
      if (querySnapshot.docs.isEmpty) {
        await _firestore.collection('users').add(userData);
        return AuthResult(success: true);
      } else {
        return AuthResult(
          success: false,
          message: "El usuario ya está registrado.",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during registration: $e");
      }
      return AuthResult(
        success: false,
        message: "Error durante el registro.",
      );
    }
  }
}
