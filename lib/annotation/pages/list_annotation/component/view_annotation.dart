import 'package:flutter/material.dart';

import '../../../entities/annotation_revision.dart';

class ViewAnnotation {
  static dynamic build(BuildContext context, AnnotationRevision annotationRevision) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: annotationRevision.idRevision != null ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 05),
                  child: Text("Revisão: ${annotationRevision.description}", style: const TextStyle(color: Colors.black45, fontSize: 22)),
                ),
              ),
              Text(annotationRevision.text!, style: const TextStyle(color: Colors.black45, fontSize: 22)),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(const BorderSide(width: 2, color: Color.fromARGB(80, 0, 0, 0))),
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20)),
                    ),
                    child: const Text("FECHAR"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
