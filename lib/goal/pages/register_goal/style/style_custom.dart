import 'package:flutter/material.dart';

class StyleCustom {
  InputDecoration decoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(161, 158, 158, 158), width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(178, 241, 146, 139), width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(178, 241, 146, 139), width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(161, 187, 187, 187), width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    );
  }

  TextStyle style() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54);
  }
}
