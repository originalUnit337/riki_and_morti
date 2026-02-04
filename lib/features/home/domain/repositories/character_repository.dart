import 'package:riki_and_morti/core/common/paged_result.dart';
import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<PagedResult<CharacterEntity>> getCharacters({required int page});
  Future<void> setFavourite(int id, bool value);
}
