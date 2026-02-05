import 'package:riki_and_morti/data/database/origin_model.dart';
import 'package:riki_and_morti/domain/entities/origin_entity.dart';

class OriginMapper {
  static OriginEntity fromModel(OriginModel model) {
    return OriginEntity(
      name: model.name,
    );
  }
}