import 'package:flutter/material.dart';

class DialogAnnotation {
  dynamic build<T>(BuildContext context, Function(String title, String description) onPressed, {String? titleArg, String? descriptionArg}) async {
    final formKey = GlobalKey<FormState>();
    final TextEditingController description = TextEditingController(text: descriptionArg);
    final TextEditingController title = TextEditingController(text: titleArg);

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(15),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Anotação", style: TextStyle(color: Colors.black45, fontSize: 18)),
                Flexible(
                  child: TextFormField(
                    controller: title,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 200,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: 'Título',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontFamily: 'helvetica_neue_light'),
                    ),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 1000,
                    style: const TextStyle(fontSize: 20, color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20.0, fontFamily: 'helvetica_neue_light'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text("CANCELA"),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextButton(
                    onPressed: () {
                      onPressed(title.text, description.text);
                      Navigator.of(context).pop(false);
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text("SALVAR"),
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
