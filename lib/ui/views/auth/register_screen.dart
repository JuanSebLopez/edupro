import 'package:edupro/models/result.dart';
import 'package:edupro/services/auth_service.dart';
import 'package:edupro/shared/widgets/textfield.dart';
import 'package:edupro/shared/widgets/warnings/warning_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final typeIdController = TextEditingController();
  final idController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String? _selectedTypeId;

  void _registerUser() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text.trim(),
        'typeId': _selectedTypeId,
        'id': idController.text,
      };

      Result result = await _authService.registerUser(userData);

      if (!mounted) return;

      if (result.success) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Registro exitoso"),
              content:
                  const Text("El usuario ha sido registrado exitosamente."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );

        // Limpiar los campos de texto
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneNumberController.clear();
        idController.clear();
        setState(() {
          _selectedTypeId = null;
        });
      } else {
        WarningSnackbar.show(context, result.message ?? "Error desconocido.");
      }
    } else {
      WarningSnackbar.show(context, "Error al llenar el formulario");
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo institucional';
    } else if (value.length < 6 || value.length > 30) {
      return 'El correo debe tener entre 6 y 30 caracteres';
    } else if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
        .hasMatch(value)) {
      return 'Ingrese un correo válido';
    } else if (value.split('@').length != 2 ||
        value.split('@')[1] != 'unicesar.edu.co') {
      return 'El correo debe tener la extensión "unicesar.edu.co"';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su contraseña';
    } else if (value.length < 8 || value.length > 100) {
      return 'La contraseña debe tener entre 8 y 100 caracteres';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su número de teléfono';
    } else if (value.trim().length != 10) {
      return 'El número de teléfono debe tener 10 caracteres';
    }
    return null;
  }

  String? _validateId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su número de identificación';
    } else if (value.length < 8 || value.length > 11) {
      return 'El número de identificación debe tener entre 8 y 11 caracteres';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'El número de identificación debe contener solo números';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crear Cuenta",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: nameController,
                labelText: "Nombre Completo",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nombre completo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: emailController,
                labelText: "Correo institucional",
                validator: _validateEmail,
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                labelText: "Contraseña",
                controller: passwordController,
                obscureText: _obscurePassword,
                validator: _validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: phoneNumberController,
                labelText: "Teléfono",
                validator: _validatePhoneNumber,
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField(
                value: _selectedTypeId,
                decoration: InputDecoration(
                  labelText: "Tipo de Documento",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: ["C.C", "T.I"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTypeId = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, seleccione un tipo de documento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: idController,
                labelText: "No. Documento",
                validator: _validateId,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(270, 51),
                  backgroundColor: const Color(0xFF204F95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(height: 0.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Color(0xFF204F95),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
