import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxCustom extends StatelessWidget {
  CheckBoxCustom({super.key, required this.isChecked, required this.onClick, this.checkColor = Colors.white, this.activeColor = Colors.grey});
  bool isChecked;
  final Function(bool?) onClick;
  Color checkColor;
  Color activeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Transform.scale(
        scale: 0.9,
        child: Checkbox(
          checkColor: checkColor,
          activeColor: activeColor,
          value: isChecked,
          shape: const CircleBorder(),
          side: WidgetStateBorderSide.resolveWith((states) => BorderSide(width: 1.0, color: activeColor)),
          onChanged: (bool? value) => onClick(value),
        ),
      ),
    );
  }
}
