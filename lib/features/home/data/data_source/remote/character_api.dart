import 'package:riki_and_morti/core/common/paged_result.dart';
import 'package:riki_and_morti/features/home/data/models/character_model.dart';

abstract class CharacterApi {
  Future<PagedResult<CharacterModel>> getCharacters({required int page});
}
