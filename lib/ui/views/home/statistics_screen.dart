import 'package:flutter/material.dart';
import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsPage createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30.0),
            SizedBox(
              width: 150,
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
                height: 20.0), // Espacio entre la imagen y los textos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/images/michael.jpg'),
                ),
                const SizedBox(
                    width: 16.0), // Espacio entre la imagen y el texto
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Bienvenido al ranking semanal',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0), // Espacio entre los textos y la tabla
            const RankingTable(),
            const SizedBox(
                height:
                    20.0), // Espacio entre el final de la tabla y la barra de navegación
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}

class RankingTable extends StatelessWidget {
  const RankingTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rankingData = [
      {'name': 'Sin registro', 'score': 0},
      {'name': 'Sin registro', 'score': 0},
      {'name': 'Sin registro', 'score': 0},
      {'name': 'Sin registro', 'score': 0},
      {'name': 'Sin registro', 'score': 0},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Ranking semanal',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10.0),
          Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: IntrinsicColumnWidth(),
            },
            children: [
              // Cabecera de la tabla
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Posición',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Estudiante',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              // Datos de la tabla
              for (int i = 0; i < 15; i++)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: i == 0
                            ? const Icon(Icons.emoji_events,
                                color: Colors.amber, size: 24.0)
                            : i == 1
                                ? const Icon(Icons.emoji_events,
                                    color: Colors.grey, size: 24.0)
                                : i == 2
                                    ? const Icon(Icons.emoji_events,
                                        color: Colors.brown, size: 24.0)
                                    : Text(
                                        '${i + 1}',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        i < rankingData.length
                            ? rankingData[i]['name']
                            : 'Sin registro',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        i < rankingData.length
                            ? rankingData[i]['score'].toString()
                            : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
