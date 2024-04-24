import 'package:edupro/shared/widgets/nav/navigation_bar.dart';
import 'package:edupro/shared/widgets/nav/statistics_card.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        backgroundColor: Colors.blue,
        leading: const Row(
          // Row for profile picture and potentially other elements
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/profile_picture.jpg'), // Replace with your profile picture path
            ),
            SizedBox(width: 16.0),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Make content scrollable if it exceeds screen height
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Add some padding around the cards
          child: Column(
            children: <Widget>[
              Row(
                // Top row of two cards
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distribute cards evenly
                children: <Widget>[
                  Expanded(
                    // Left card (Statistics)
                    child: _buildCard(
                      title: 'Estadísticas',
                      icon: Icons.trending_up,
                      count: '123',
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    // Right card (Completion)
                    child: _buildCard(
                      title: 'Completados',
                      icon: Icons.done,
                      count: '456',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0), // Spacing between rows
              Row(
                // Bottom row of two cards
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    // Left card (Challenges)
                    child: _buildCard(
                      title: 'Desafíos',
                      icon: Icons.lightbulb,
                      count: '789',
                      color: Colors.orange,
                    ),
                  ),
                  Expanded(
                    // Right card (Experience)
                    child: _buildCard(
                      title: 'Experiencia',
                      icon: Icons.star_border,
                      count: '1011',
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}

Widget _buildCard({
  required String title,
  required IconData icon,
  required String count,
  required Color color,
}) {
  return StatisticsCard(
    title: title,
    icon: icon,
    count: count,
    color: color,
  );
}
