import 'package:riki_and_morti/core/database/origin_model.dart';
import 'package:riki_and_morti/shared/domain/entities/origin_entity.dart';

class OriginMapper {
  static OriginEntity fromModel(OriginModel model) {
    return OriginEntity(
      name: model.name,
    );
  }
}