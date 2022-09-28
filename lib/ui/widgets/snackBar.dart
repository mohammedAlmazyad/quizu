import 'package:flutter/material.dart';

void showActionSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.all(12),
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(seconds: 4),
    content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
