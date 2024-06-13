import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edupro/models/result.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> signIn(String identifier, String password) async {
    try {
      // Búsqueda por email o username
      QuerySnapshot userQuery = await _firestore
          .collection('user')
          .where('password', isEqualTo: password)
          .where('status', isEqualTo: 'Active')
          .where(Filter.or(
            Filter('email', isEqualTo: identifier),
            Filter('username', isEqualTo: identifier),
          ))
          .get();

      if (userQuery.docs.isNotEmpty) {
        var userDoc = userQuery.docs.first;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userDoc.id);
        await prefs.setString('userEmail', userDoc['email']);
        await prefs.setString('userName', userDoc['name']);
        await prefs.setString('username', userDoc['username']);

        // Comprueba si el usuario es un profesor
        QuerySnapshot teacherQuery = await _firestore
            .collection('teacher')
            .where('userId', isEqualTo: userDoc.id)
            .get();

        if (teacherQuery.docs.isNotEmpty) {
          await prefs.setString('userRole', 'teacher');
        } else {
          await prefs.setString('userRole', 'student');
        }
        return Result(success: true);
      } else {
        return Result(
          success: false,
          message:
              "Email, nombre de usuario o contraseña incorrectos, o el usuario no está activo.",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error durante el inicio de sesión: $e");
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

      QuerySnapshot usernameQuery = await _firestore
          .collection('user')
          .where('username', isEqualTo: userData['username'])
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
              "El número de teléfono ya se encuentra registrado con una cuenta.",
        );
      } else if (usernameQuery.docs.isNotEmpty) {
        return Result(
          success: false,
          message: "El nombre de usuario ya se encuentra registrado.",
        );
      } else {
        // Crear el documento en la colección user
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

        // Crear el documento en la colección student
        await _firestore.collection('student').add({
          'career': userData['career'],
          'points': 0, // Puntos iniciales
          'userId': userRef.id,
        });

        return Result(success: true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error durante el registro: $e");
      }
      return Result(
        success: false,
        message: "Error durante el registro.",
      );
    }
  }
}
