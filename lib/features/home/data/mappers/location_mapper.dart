import 'package:riki_and_morti/core/database/location_model.dart';
import 'package:riki_and_morti/features/home/domain/entities/location_entity.dart';

class LocationMapper {
  static LocationEntity fromModel(LocationModel model) {
    return LocationEntity(
      name: model.name,
    );
  }
}