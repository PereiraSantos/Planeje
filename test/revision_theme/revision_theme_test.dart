import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';
import 'package:planeje/revision_theme/utils/insert_revision_theme.dart';
import 'package:planeje/revision_theme/utils/update_revision_theme.dart';

void main() {
  group('Teste de registro tema de revisão', () {
    test('Espero que registre', () async {
      InsertRevisioTheme insertRevisioTheme = InsertRevisioTheme(NockRevisionThemeDatabase());

      int result = await insertRevisioTheme.write(RevisionTheme(description: 'Flutter'));

      expect(1, result);
    });
    test('Espero que registre list', () async {
      InsertRevisioTheme insertRevisioTheme = InsertRevisioTheme(NockRevisionThemeDatabase());

      List<int> result = await insertRevisioTheme.writeList([RevisionTheme(description: 'Flutter'), RevisionTheme(description: 'Poo')]);

      expect([1, 2], result);
    });
    test('Espero que faça update', () async {
      UpdateRevisionTheme updateRevisioTheme = UpdateRevisionTheme(NockRevisionThemeDatabase());

      int? result = await updateRevisioTheme.write(RevisionTheme(id: 1, description: 'Flutter'));

      expect(1, result);
    });
  });
}

class NockRevisionThemeDatabase implements RevisionThemeDatabaseFactory {
  @override
  Future<void> deleteTable() async {}

  @override
  Future<RevisionTheme?> disableRevisionThemeById(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionTheme>> findAllRevisionTheme() async {
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionTheme>?> findAllRevisionThemeSync() async {
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text) async {
    throw UnimplementedError();
  }

  @override
  Future<RevisionTheme?> findRevisionThemeById(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionTheme>?> findRevisionThemeDisable() async {
    throw UnimplementedError();
  }

  @override
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme) async {
    return 1;
  }

  @override
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes) async {
    return [1, 2];
  }

  @override
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme) async {
    return 1;
  }
}
