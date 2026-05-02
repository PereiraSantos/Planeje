import 'package:flutter/material.dart';

class ButtonSimpleCustom extends StatelessWidget {
  const ButtonSimpleCustom({super.key, required this.onTap, required this.label});

  final Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ),
    );
  }
}
