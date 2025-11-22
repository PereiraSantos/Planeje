import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    this.onChange,
    this.inputFormatter,
    this.maxLine = 1,
    this.minLine = 1,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.borderRadius,
    this.valid = true,
    this.suffixIcon,
    this.textArea = false,
    this.readOnly = false,
    this.padding = const EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 10),
    this.fontSize = 18,
    this.autofocus,
    this.contentPadding,
  });

  final TextEditingController controller;
  final String? hintText;
  List<TextInputFormatter>? inputFormatter = [];
  final int maxLine;
  final int minLine;
  final TextInputType keyboardType;
  final double? borderRadius;
  final bool valid;
  final Widget? suffixIcon;
  final bool textArea;
  final bool readOnly;
  final Function(String?)? onChange;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final bool? autofocus;
  final EdgeInsetsGeometry? contentPadding;

  InputBorder theme(double value) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(value),
      borderSide: const BorderSide(color: Colors.black54, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        minLines: minLine,
        readOnly: readOnly,
        autofocus: autofocus ?? true,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        enableInteractiveSelection: false,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontSize: fontSize!, color: Colors.black54),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.black54, fontSize: fontSize!, fontWeight: FontWeight.w300),
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.black, fontSize: fontSize!, fontFamily: 'helvetica_neue_light'),
          border: borderRadius != null ? theme(borderRadius!) : null,
          contentPadding: contentPadding,
        ),
        validator: (value) {
          if (valid) {
            return validator(value);
          }
          return null;
        },
        onChanged: (value) {
          if (onChange != null) onChange!(value);
        },
      ),
    );
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório!!!';
    }
    return null;
  }
}
