import 'package:riki_and_morti/core/common/paged_result.dart';
import 'package:riki_and_morti/features/home/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<PagedResult<CharacterEntity>> getCharacters({required int page});
}
