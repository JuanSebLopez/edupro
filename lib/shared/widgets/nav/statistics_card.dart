import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
    required this.percentage,
    required this.color,
  });

  final String title;
  final IconData icon;
  final String count;
  final String percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 30.0,
                  color: color,
                ),
                const SizedBox(width: 3.0), // Ajusta el ancho del SizedBox
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              count,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 14.0,
                color: color.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
