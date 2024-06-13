import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/models/result.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> signIn(String email, String password) async {
    try {
      QuerySnapshot emailQuery = await _firestore
          .collection('user')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        var userDoc = emailQuery.docs.first;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userDoc.id);
        await prefs.setString('userEmail', userDoc['email']);
        await prefs.setString('userName', userDoc['name']);
        await prefs.setString('username', userDoc['username']);
        await prefs.setString('userProfile', userDoc['profile']);
        await prefs.setString('userPhoneNumber', userDoc['phoneNumber']);
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
          .collection('user')
          .where('email', isEqualTo: userData['email'])
          .get();

      QuerySnapshot documentQuery = await _firestore
          .collection('user')
          .where('document', isEqualTo: userData['document'])
          .get();

      QuerySnapshot phoneQuery = await _firestore
          .collection('user')
          .where('phoneNumber', isEqualTo: userData['phoneNumber'])
          .get();

      if (emailQuery.docs.isNotEmpty) {
        return Result(
          success: false,
          message: "El correo electrónico digitado ya se encuentra registrado.",
        );
      } else if (documentQuery.docs.isNotEmpty) {
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
        // Crear el documento en la coleccion user
        DocumentReference userRef = await _firestore.collection('user').add({
          'name': userData['name'],
          'email': userData['email'],
          'username': userData['username'],
          'password': userData['password'],
          'phoneNumber': userData['phoneNumber'],
          'documentType': userData['documentType'],
          'document': userData['document'],
          'profile': 'Hola bienvenido a mi perfil', // Perfil inicial
          'status': 'Active',
        });

        // Crear el documento en la coleccion student
        await _firestore.collection('student').add({
          'career': userData['career'],
          'points': 0, // Puntos iniciales
          'userId': userRef.id,
        });
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
