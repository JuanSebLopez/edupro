import 'package:edupro/models/result.dart';
import 'package:edupro/services/auth_service.dart';
import 'package:edupro/shared/widgets/warnings/warning_snackbar.dart';
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
  String _username = '';
  String _userProfile = '';
  String _userEmail = '';
  String _userPhoneNumber = '';

  bool _isEditing = false;

  final AuthService _authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Sin nombre';
      _username = prefs.getString('username') ?? 'Sin nombre de usuario';
      _userProfile = prefs.getString('userProfile') ?? 'Sin descripcion';
      _userEmail = prefs.getString('userEmail') ?? 'Sin correo';
      _userPhoneNumber = prefs.getString('userPhoneNumber') ?? 'Sin número';

      usernameController.text = _username;
      profileController.text = _userProfile;
      phoneNumberController.text = _userPhoneNumber;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    profileController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _modUser() async {
    if (usernameController.text.trim().isEmpty ||
        phoneNumberController.text.trim().isEmpty) {
      WarningSnackbar.show(context,
          "El nombre de usuario y el número de teléfono no pueden ser nulos");
      return;
    }

    Map<String, dynamic> userData = {};

    // Añadir campos solo si no están vacíos
    if (usernameController.text.trim().isNotEmpty) {
      userData['username'] = usernameController.text.trim();
    }
    if (profileController.text.trim().isNotEmpty) {
      userData['profile'] = profileController.text.trim();
    }
    if (phoneNumberController.text.trim().isNotEmpty) {
      userData['phoneNumber'] = phoneNumberController.text.trim();
    }

    _saveUserData();
    Result result = await _authService.updateUser(userData);

    if (!mounted) return;

    if (result.success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Modificación exitosa"),
            content: Text("El usuario ha sido modificado exitosamente."),
          );
        },
      );
    }
  }

  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);
    prefs.setString('userProfile', profileController.text);
    prefs.setString('userPhoneNumber', phoneNumberController.text);
    setState(() {
      _username = usernameController.text;
      _userProfile = profileController.text;
      _userPhoneNumber = phoneNumberController.text;
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: _isEditing ? const Icon(Icons.check) : const Icon(Icons.edit),
            onPressed: _isEditing ? _modUser : _toggleEditing,
          ),
        ],
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
              const SizedBox(height: 20.0),
              _buildProfileImage(),
              const SizedBox(height: 20.0),
              _buildSettingsField('Nombre', _userName),
              _buildEditableSettingsField(
                  'Nombre de usuario', _username, usernameController),
              _buildEditableSettingsField(
                  'Descripción', _userProfile, profileController),
              _buildEditableSettingsField('Número de teléfono',
                  _userPhoneNumber, phoneNumberController),
              _buildSettingsField('Correo electrónico', _userEmail),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
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

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage('assets/images/michael.jpg'),
          ),
        ),
        IconButton(
          alignment: Alignment.center,
          onPressed: () {},
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
    );
  }

  Widget _buildSettingsField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildEditableSettingsField(
      String label, String value, TextEditingController controller) {
    if (_isEditing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6.0),
          Container(
            constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
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
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      );
    } else {
      return _buildSettingsField(label, value);
    }
  }
}
