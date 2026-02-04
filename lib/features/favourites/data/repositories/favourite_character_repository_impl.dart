import 'package:riki_and_morti/features/favourites/domain/repositories/favourite_character_repository.dart';
import 'package:riki_and_morti/shared/data/mappers/character_mapper.dart';
import 'package:riki_and_morti/shared/data/data/data_source/local/character_drift.dart';
import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';

class FavouriteCharacterRepositoryImpl implements FavouriteCharacterRepository {
  final CharacterDrift local;

  FavouriteCharacterRepositoryImpl({required this.local});

  @override
  Stream<List<CharacterEntity>> watchFavourites() {
    return local.watchFavourites().map(
      (list) => list.map(CharacterMapper.dbModelToEntity).toList(),
    );
  }
  
  @override
  Future<void> setFavourite(int id, bool value) {
    return local.setFavourite(id, value);
  }
}
