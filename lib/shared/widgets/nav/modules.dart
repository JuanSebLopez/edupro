import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final String title;
  final String description;
  //final String imagePath; // Path to the module image

  const ModuleCard({
    super.key,
    required this.title,
    required this.description,
    //required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Image.asset(imagePath), // Display the module image
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(description),
          ],
        ),
      ),
    );
  }
}
