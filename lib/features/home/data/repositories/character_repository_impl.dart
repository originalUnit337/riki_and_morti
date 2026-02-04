import 'package:riki_and_morti/core/common/paged_result.dart';
import 'package:riki_and_morti/shared/data/data/data_source/local/character_drift.dart';
import 'package:riki_and_morti/features/home/data/data_source/remote/character_api.dart';
import 'package:riki_and_morti/shared/data/mappers/character_mapper.dart';
import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';
import 'package:riki_and_morti/features/home/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDrift local;
  final CharacterApi remote;

  CharacterRepositoryImpl({required this.local, required this.remote});

  static const int pageSize = 20;

  @override
  Future<PagedResult<CharacterEntity>> getCharacters({
    required int page,
  }) async {
    try {
      final remotePage = await remote.getCharacters(page: page);

      await local.cacheCharacters(
        remotePage.items
            .map((model) => CharacterMapper.modelToDbModel(model))
            .toList(),
      );

      return PagedResult(
        items: remotePage.items
            .map((model) => CharacterMapper.fromModel(model))
            .toList(),
        hasNext: remotePage.hasNext,
      );
    } catch (_) {
      final cached = await local.getCharacters(page: page);

      return PagedResult(
        items: cached
            .map((model) => CharacterMapper.dbModelToEntity(model))
            .toList(),
        hasNext: cached.length == pageSize,
      );
    }
  }
  
  @override
  Future<void> setFavourite(int id, bool value) {
    return local.setFavourite(id, value);
  }
}
