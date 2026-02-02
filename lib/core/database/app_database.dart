import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riki_and_morti/core/database/converters/location_converter.dart';
import 'package:riki_and_morti/core/database/converters/origin_converter.dart';
import 'package:riki_and_morti/core/database/converters/string_list_converter.dart';
import 'package:riki_and_morti/core/database/location_model.dart';
import 'package:riki_and_morti/core/database/origin_model.dart';

part 'app_database.g.dart';

@DataClassName('CharacterDbModel')
class Characters extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  TextColumn get origin => text().map(const OriginConverter())();
  TextColumn get location => text().map(const LocationConverter())();
  TextColumn get image => text()();
  TextColumn get episode => text().map(const StringListConverter())();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Characters])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File([dbFolder.path, 'app.db'].join());
      return NativeDatabase.createInBackground(file);
    });
  }
}