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
              apiKey: "AIzaSyDq50hLcg97qlXvaU-R1CuZDOGaR0onJhQ", //listo
              authDomain: "edupro-45bb5.firebaseapp.com", //listo
              databaseURL:
                  "https://edupro-45bb5-default-rtdb.firebaseio.com", //listo
              projectId: "edupro-45bb5", //listo
              storageBucket: "edupro-45bb5.appspot.com", //listo
              messagingSenderId: "727905531405", //listo
              appId: "1:727905531405:android:53830fadc4f845a62fc744")) //listo
      : await Firebase.initializeApp();
  runApp(const App());
}
