import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _userName = '';
  String _email = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
      _email = prefs.getString('userEmail') ?? 'Sin correo';
      // Asegúrate de almacenar y recuperar el número de teléfono en el registro e inicio de sesión
      _phoneNumber = prefs.getString('userPhoneNumber') ?? 'Sin número';
    });
  }

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
        padding: const EdgeInsets.all(20.0),
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
                      backgroundImage: AssetImage('assets/images/michael.jpg'),
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
                          color: Colors.white,
                          size: 30,
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _buildSettingsField('Nombre', _userName),
              _buildSettingsField('Sobre mí', 'Sin descripcion'),
              _buildSettingsField('Número de teléfono', _phoneNumber),
              _buildSettingsField('Correo electrónico', _email),
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
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
