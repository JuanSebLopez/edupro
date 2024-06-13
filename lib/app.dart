import 'package:edupro/ui/views/auth/welcome_screen.dart';
import 'package:edupro/ui/views/home/home_screen.dart';
import 'package:edupro/ui/views/home/questionaries/add_questionary_screen.dart';
import 'package:edupro/ui/views/home/questionaries/questionary_list_screen.dart';
import 'package:edupro/ui/views/home/settings_screen.dart';
import 'package:edupro/ui/views/home/statistics_screen.dart';
import 'package:edupro/ui/views/auth/login_screen.dart';
import 'package:edupro/ui/views/home/profile_screen.dart';
import 'package:edupro/ui/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//La clase padre que llamará a todas las demás clases del aplicativo
class App extends StatelessWidget {
  //Constante del App que permite usarla en otros componentes
  const App({super.key});

  //Sobre escribe el contenido de la clase
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Tema de la aplicación
      theme: ThemeData.light(),
      // Título del aplicativo
      title: 'Edu-Pro',
      // Ruta inicial del aplicativo
      initialRoute: '/home',
      // Rutas generales del aplicativo
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/homeScreen': (context) => const HomeScreenPage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/questionaryList': (context) => const QuestionaryListScreen(
              competence: '',
              difficulty: '',
            ),
        '/addQuestionary': (context) => const AddQuestionaryScreen(),
      },
    );
  }
}
