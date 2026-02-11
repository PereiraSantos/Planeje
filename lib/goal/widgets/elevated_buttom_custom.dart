import 'package:flutter/material.dart';

class ElevatedButtomCustom extends StatelessWidget {
  const ElevatedButtomCustom({super.key, required this.onPressed, required this.title, this.color = Colors.blue});

  final Function onPressed;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(width: 1.0, color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => onPressed(),
      child: Text(title, style: TextStyle(color: Colors.grey, fontSize: 15)),
    );
  }
}
