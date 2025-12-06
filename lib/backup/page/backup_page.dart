import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planeje/backup/component/list_backup.dart';
import 'package:planeje/backup/controller/backup_controller.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';
import 'package:planeje/widgets/text_button_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

import '../../widgets/dialog_delete.dart';

class BackupPage extends StatelessWidget {
  BackupPage({super.key});

  final GlobalKey<FormState> backupFormKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final BackupController _backupController = BackupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          'Backup',
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: backupFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(controller: _name, maxLine: 1, hintText: 'Nome', keyboardType: TextInputType.text, textArea: false),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
                  child: ListenableBuilder(
                    listenable: _backupController,
                    builder: (context, child) {
                      if (_backupController.backups.isEmpty) return Text('Nenhum backup encontrado!!!');
                      return ListBackup(
                        backups: _backupController.backups,
                        onClickDelete: (context, backup) {
                          DialogDelete().build(context, Uri.file(backup.path).pathSegments.last, () async {
                            final File file = File(backup.path);

                            await _backupController.deletFile(file);

                            return true;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterWidget(
          children: [
            TextButtonWidget.back(() => Navigator.pop(context, false)),
            TextButtonWidget.save(() => _backupController.save(_name.text, backupFormKey)),
          ],
        ),
      ],
    );
  }
}
