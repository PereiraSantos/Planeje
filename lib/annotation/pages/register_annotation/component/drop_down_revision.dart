import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';

// ignore: must_be_immutable
class DropDownButtonRevision extends StatelessWidget {
  DropDownButtonRevision({
    super.key,
    required this.onClick,
    this.idRevision,
  }) {
    if (idRevision != null) dropdownValue = idRevision;
  }

  final Function(int?) onClick;
  final int? idRevision;
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetRevision(RevisionDatabase()).findAllRevisions(),
      builder: (BuildContext context, AsyncSnapshot<List<Revision>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DropdownButtonFormField<int>(
                hint: const Text("Tema", style: TextStyle(fontSize: 17, color: Colors.grey)),
                initialValue: dropdownValue,
                icon: const Icon(Icons.expand_more),
                elevation: 14,
                isExpanded: true,
                isDense: true,
                style: const TextStyle(color: Colors.black54),
                onChanged: (int? value) => onClick(value),
                items: snapshot.data!.map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: Text('${value.description}'),
                  );
                }).toList(),
              ),
            );
          }
          return const SizedBox();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
