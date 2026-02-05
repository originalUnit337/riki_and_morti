import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riki_and_morti/data/database/location_model.dart';

class LocationConverter extends TypeConverter<LocationModel, String> {
  const LocationConverter();
  @override
  LocationModel fromSql(String fromDb) {
    return LocationModel.fromJson(jsonDecode(fromDb));
  }

  @override
  String toSql(LocationModel value) {
    return jsonEncode(value.toJson(value));
  }

}