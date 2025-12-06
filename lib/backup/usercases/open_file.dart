import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class OpenFile {
  Future<Directory> _pathSaveDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    return tempDir;
  }

  Future<void> backup(String name) async {
    File file = File("/data/data/com.br.planeje/databases/app_database.db");
    Uint8List bytes = file.readAsBytesSync();

    Directory directory = await _pathSaveDatabase();

    File fileBackup = File('${directory.path}/$name.db');

    await fileBackup.writeAsBytes(bytes);
  }

  Future<List<FileSystemEntity>> getBackup() async {
    Directory tempDir = await _pathSaveDatabase();

    return tempDir.listSync();
  }

  Future<bool> deleteFile(File file) async {
    if (await file.exists()) await file.delete();

    return true;
  }
}
