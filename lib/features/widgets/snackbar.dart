import 'package:flutter/material.dart';

class SnackBarUtil {
  void simpleSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void snackBarWithAction(BuildContext context, String message, String label,
      void Function() onPressed) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: label,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
