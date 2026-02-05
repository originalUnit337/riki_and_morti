import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riki_and_morti/data/database/origin_model.dart';

class OriginConverter
    extends TypeConverter<OriginModel, String> {
  const OriginConverter();

  @override
  OriginModel fromSql(String fromDb) {
    return OriginModel.fromJson(jsonDecode(fromDb));
  }

  @override
  String toSql(OriginModel value) {
    return jsonEncode(value.toJson());
  }
}
