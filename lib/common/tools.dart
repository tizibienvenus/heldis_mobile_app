import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showSnackBar(
    {required BuildContext context,
    required String message,
    required Color color,
    required IconData icon,
    required Color bgColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

showWarningSnackBar({required BuildContext context, required String message}) {
  showSnackBar(
      context: context,
      message: message,
      color: Colors.white,
      icon: Icons.warning_amber_rounded,
      bgColor: Colors.orange);
}
