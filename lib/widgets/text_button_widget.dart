import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({super.key, required this.label, required this.onClick, this.padding});

  final String label;
  final Function onClick;
  final EdgeInsetsGeometry? padding;

  factory TextButtonWidget.cancel(Function onClick) => TextButtonWidget(label: 'CANCELA', onClick: onClick);
  factory TextButtonWidget.back(Function onClick) => TextButtonWidget(label: 'VOLTAR', onClick: onClick);
  factory TextButtonWidget.save(Function onClick) => TextButtonWidget(label: 'SALVAR', onClick: onClick);
  factory TextButtonWidget.sync(Function onClick) => TextButtonWidget(label: 'SINCRONIZAR', onClick: onClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: TextButton(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14.0, fontFamily: 'helvetica_neue_light', color: Colors.black54),
          ),
        ),
        onPressed: () => onClick(),
      ),
    );
  }
}
