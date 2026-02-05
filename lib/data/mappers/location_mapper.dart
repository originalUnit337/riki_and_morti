import 'package:riki_and_morti/data/database/location_model.dart';
import 'package:riki_and_morti/domain/entities/location_entity.dart';

class LocationMapper {
  static LocationEntity fromModel(LocationModel model) {
    return LocationEntity(
      name: model.name,
    );
  }
}