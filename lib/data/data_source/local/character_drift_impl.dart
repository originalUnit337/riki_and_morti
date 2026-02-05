import 'package:drift/drift.dart';
import 'package:riki_and_morti/data/database/app_database.dart';
import 'package:riki_and_morti/data/data_source/local/character_drift.dart';

class CharacterDriftImpl implements CharacterDrift {
  final AppDatabase db;

  static const int _pageSize = 20;

  CharacterDriftImpl({required this.db});

  @override
  Future<void> cacheCharacters(List<CharacterDbModel> values) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(db.characters, values);
    });
  }

  @override
  Future<List<CharacterDbModel>> getCharacters({required int page}) async {
    final offset = (page - 1) * _pageSize;

    final query = db.select(db.characters)..limit(_pageSize, offset: offset);

    return query.map((row) => row).get();
  }

  @override
  Future<void> setFavourite(int id, bool value) {
    return (db.update(db.characters)..where((tbl) => tbl.id.equals(id))).write(
      CharactersCompanion(isFavourite: Value(value)),
    );
  }
  
  @override
  Stream<List<CharacterDbModel>> watchFavourites() {
    return (db.select(db.characters)..where((tbl) => tbl.isFavourite.equals(true))).watch();
  }
}
