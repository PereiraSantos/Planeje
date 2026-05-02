import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.child, required this.color, this.width, this.margin});

  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 25,
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: color, width: 1),
          left: BorderSide(color: color, width: 1),
          right: BorderSide(color: color, width: 1),
          bottom: BorderSide(color: color, width: 1),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}
