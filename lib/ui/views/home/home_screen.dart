import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/modules.dart'; // Assuming modules.dart is in the edupro folder

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10.0), // Espacio agregado
              Container(
                margin: const EdgeInsets.all(4.0),
                child: Image.asset('ImgHome2Png.png'),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ModuleCard(
                      title: 'Ingles',
                      porcentage: '100%',
                      color: Colors.blue,
                      width: 300,
                    ),
                    ModuleCard(
                      title: 'Español',
                      porcentage: '100%',
                      color: Colors.green,
                      width: 300,
                    ),
                    ModuleCard(
                      title: 'Matematicas',
                      porcentage: '100%',
                      color: Colors.orange,
                      width: 300,
                    ),
                    ModuleCard(
                      title: 'Programación',
                      porcentage: '100%',
                      color: Colors.purple,
                      width: 300,
                    ),
                    ModuleCard(
                      title: 'Física',
                      porcentage: '100%',
                      color: Colors.red,
                      width: 300,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height:
                      80), // Agregamos un espacio en la parte inferior para que no se solape con el bottomNavigationBar
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
