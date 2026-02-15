import 'package:riki_and_morti/core/pagination/paged_result.dart';
import 'package:riki_and_morti/data/models/character_model.dart';

abstract class CharacterApi {
  Future<PagedResult<CharacterModel>> getCharacters({required int page});
}
