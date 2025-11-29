import 'package:flutter/material.dart';

class MessageUser {
  static void success(BuildContext context, String message) async => _message(context, message, 'Sucesso', Colors.green);

  static void alert(BuildContext context, String message) async => _message(context, message, 'Alerta', Colors.yellow, Colors.black);

  static void error(BuildContext context, String message) async => _message(context, message, 'Erro', Colors.red);

  static void _message(BuildContext context, String message, String title, Color backgroundColor, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(0),
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey, width: 0.8),
        ),

        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100, left: 10, right: 10),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        content: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 20, color: color ?? Colors.white)),
              Text('Login incorreto!!!', style: TextStyle(fontSize: 20, color: color ?? Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
