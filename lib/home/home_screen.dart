import 'package:edupro/home/nav/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:edupro/home/nav/modules.dart'; // Assuming modules.dart is in the edupro folder

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(4.0),
              child: Image.asset('ImgHome2Png.png'),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity, // Occupy full width
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
                  // Widgets modulos
                  Text('Módulos'),
                  SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ModuleCard(
                          title: 'Modulo 1',
                          description: 'Descripcion 1',
                          //imagePath: ''
                        ),
                      ]),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ModuleCard(
                        title: 'Módulo 2',
                        description: 'Descripción breve del módulo 2',
                        //imagePath: '',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ModuleCard(
                        title: 'Módulo 3',
                        description: 'Descripción breve del módulo 3',
                        //imagePath: '',
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button action
              },
              child: const Text('Ver más módulos'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
