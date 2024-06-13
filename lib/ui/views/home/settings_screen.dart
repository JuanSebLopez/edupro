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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userProfileController = TextEditingController();
  final TextEditingController _userPhoneNumberController = TextEditingController();

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

      _usernameController.text = _username;
      _userProfileController.text = _userProfile;
      _userPhoneNumberController.text = _userPhoneNumber;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _userProfileController.dispose();
    _userPhoneNumberController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('userProfile', _userProfileController.text);
    prefs.setString('userPhoneNumber', _userPhoneNumberController.text);
    setState(() {
      _username = _usernameController.text;
      _userProfile = _userProfileController.text;
      _userPhoneNumber = _userPhoneNumberController.text;
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
            onPressed: _isEditing ? _saveUserData : _toggleEditing,
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
                  'Nombre de usuario', _username, _usernameController),
              _buildEditableSettingsField(
                  'Descripción', _userProfile, _userProfileController),
              _buildEditableSettingsField('Número de teléfono',
                  _userPhoneNumber, _userPhoneNumberController),
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
          onTap: () {
          },
          child: const CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage('assets/images/michael.jpg'),
          ),
        ),
        IconButton(
          alignment: Alignment.center,
          onPressed: () {
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
