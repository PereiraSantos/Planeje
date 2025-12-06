import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

class ListBackup extends StatelessWidget {
  const ListBackup({super.key, required this.backups, required this.onClickDelete});

  final List<FileSystemEntity> backups;
  final Function(BuildContext, FileSystemEntity) onClickDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: backups.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 8, child: Text(Uri.file(backups[index].path).pathSegments.last)),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final XFile file = XFile(backups[index].path);

                    final params = ShareParams(files: [file]);

                    SharePlus.instance.share(params);
                  },
                  child: Icon(Icons.share, size: 18, color: Colors.blue),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onClickDelete(context, backups[index]),
                  child: Icon(Icons.delete, size: 18, color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
