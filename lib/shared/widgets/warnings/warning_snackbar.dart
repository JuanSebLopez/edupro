import 'package:flutter/material.dart';

class WarningSnackbar {
  static void show(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 17, 142, 245),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
