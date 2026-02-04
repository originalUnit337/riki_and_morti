import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';

abstract class FavouriteCharacterRepository {
  Stream<List<CharacterEntity>> watchFavourites();
}