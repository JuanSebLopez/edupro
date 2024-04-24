import 'package:edupro/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:firebase_core/firebase_core.dart';

//Metodo que llama al App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyA-5zJkc5CIitRspUqVIrEvjW-Epupv6f8",
              authDomain: "edupro-45bb5.firebaseapp.com", //listo
              databaseURL:
                  "https://edupro-45bb5-default-rtdb.firebaseio.com", //listo
              projectId: "edupro-45bb5", //listo
              storageBucket: "gs://edupro-45bb5.appspot.com", //listo
              messagingSenderId: "1095817888283",
              appId: "1:1095817888283:web:59501d01ab8bfa71c92ebe"))
      : await Firebase.initializeApp();
  runApp(const App());
}
