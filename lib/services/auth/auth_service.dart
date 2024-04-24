import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print('Error al registrar usuario: $e');
      }
      _showErrorDialog(context, 'Error al registrar usuario: $e');
      rethrow;
    }
  }
}

// TODO: ME FALTA SABER DONDE VA EL SHOWERRORDIALOG POR QUE NO SE SI COLOCARLO EN LA LOGICA O VISTA