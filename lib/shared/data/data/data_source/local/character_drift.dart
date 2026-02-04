import 'package:riki_and_morti/core/database/app_database.dart';

abstract class CharacterDrift {
  Future<void> cacheCharacters(List<CharacterDbModel> values);
  Future<List<CharacterDbModel>> getCharacters({required int page});
  Future<void> setFavourite(int id, bool value);
  Stream<List<CharacterDbModel>> watchFavourites();
}
