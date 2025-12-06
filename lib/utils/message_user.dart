import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageUser {
  static void success(String message) async => _message(message, 'Sucesso', Colors.green, Icons.check_circle_outline, Colors.white);

  static void alert(String message) async => _message(message, 'Alerta', Colors.yellow, Icons.error_outline, Colors.black);

  static void error(String message) async => _message(message, 'Erro', Colors.red, Icons.warning_amber_rounded, Colors.white);

  static void _message(String message, String title, Color backgroundColor, IconData icon, Color color) {
    Get.snackbar(
      title,
      message,
      colorText: color,
      icon: Icon(icon, color: color),
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      backgroundColor: backgroundColor,
      duration: Duration(seconds: Duration(milliseconds: 3).inMilliseconds),
    );
  }
}
