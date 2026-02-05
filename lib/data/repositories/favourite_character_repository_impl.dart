import 'package:riki_and_morti/domain/entities/character_entity.dart';
import 'package:riki_and_morti/domain/repositories/favourite_character_repository.dart';
import 'package:riki_and_morti/data/mappers/character_mapper.dart';
import 'package:riki_and_morti/data/data_source/local/character_drift.dart';

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
