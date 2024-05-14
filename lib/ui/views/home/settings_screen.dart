import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Agregar padding de 10.0
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 0),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Agregar aquí la lógica para abrir la galería
                    },
                    child: const CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('michael7.jpg'),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      // Agregar aquí la lógica necesaria
                    },
                    icon: const Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Colors
                              .white, // Color del centro del icono igual al color de fondo del módulo
                          size: 30, // Tamaño del icono
                        ),
                        Icon(
                          Icons.add,
                          color: Colors
                              .blue, // Color de la '+' en el centro del icono
                          size: 20, // Tamaño de la '+'
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _buildSettingsField('Nombre', 'Juan David Peralta Fuentes'),
              _buildSettingsField(
                  'Sobre mí', 'Texto descriptivo sobre el usuario'),
              _buildSettingsField('Número de teléfono', '+1234567890'),
              _buildSettingsField('Correo electrónico', 'correo@example.com'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  Get.toNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 51),
                  backgroundColor: const Color(0xFF204F95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: value,
              prefix: const Text('@'),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
