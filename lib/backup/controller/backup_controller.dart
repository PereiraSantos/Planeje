import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planeje/backup/usercases/open_file.dart';
import 'package:planeje/utils/message_user.dart';

class BackupController with ChangeNotifier {
  List<FileSystemEntity> backups = [];

  BackupController() {
    _listBackup();
  }

  void save(String name, GlobalKey<FormState> backupFormKey) async {
    if (!backupFormKey.currentState!.validate()) return;

    await OpenFile().backup(name);

    await _listBackup();

    _messageUser();
  }

  Future<void> _listBackup() async {
    backups = await OpenFile().getBackup();

    notifyListeners();
  }

  void _messageUser() => MessageUser.success('backup realizado com sucesso.');

  Future<void> deletFile(File file) async {
    await OpenFile().deleteFile(file);
    await _listBackup();
  }
}
