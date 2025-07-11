import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PersistentFooterWidget extends StatelessWidget {
  PersistentFooterWidget({super.key, required this.children});

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
