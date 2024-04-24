import 'package:edupro/home/home_login.dart';
import 'package:edupro/home/home_screen.dart';
import 'package:edupro/home/pages/graphs.dart';
import 'package:edupro/home/pages/login.dart';
import 'package:edupro/home/pages/profile.dart';
import 'package:edupro/home/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Clase App
//La clase padre que llamará a todas las demás clases del aplicativo
class App extends StatelessWidget {
  //Constante del App que permite usarla en otros componentes
  const App({super.key});

  //Sobre escribe el contenido de la clase
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //Tema de la aplicacion
        theme: ThemeData.light(),
        //Titulo del aplicativo
        title: 'Edu-Pro',
        //Ruta inicial del aplicativo
        initialRoute: '/home',
        //Rutas generales del aplicativo
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/statistics': (context) => const StatisticsPage(),
          '/homeScreen': (context) => const HomeScreenPage(),
          '/profile': (context) => const ProfilePage(),
        });
  }
}
