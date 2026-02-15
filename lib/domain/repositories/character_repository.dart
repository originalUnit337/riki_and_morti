import 'package:riki_and_morti/core/pagination/paged_result.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<PagedResult<CharacterEntity>> getCharacters({required int page});
  Future<void> setFavourite(int id, bool value);
}
