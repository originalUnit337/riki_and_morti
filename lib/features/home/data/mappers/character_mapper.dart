import 'package:riki_and_morti/core/database/app_database.dart';
import 'package:riki_and_morti/features/home/data/mappers/location_mapper.dart';
import 'package:riki_and_morti/features/home/data/mappers/origin_mapper.dart';
import 'package:riki_and_morti/features/home/data/models/character_model.dart';
import 'package:riki_and_morti/features/home/domain/entities/character_entity.dart';

class CharacterMapper {
  static CharacterEntity fromModel(CharacterModel model) {
    return CharacterEntity(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      type: model.type,
      gender: model.gender,
      created: model.created,
      origin: OriginMapper.fromModel(model.origin),
      location: LocationMapper.fromModel(model.location),
      episodes: model.episodes,
      image: model.image,
      url: model.url,
    );
  }

  static CharacterEntity dbModelToEntity(CharacterDbModel model) {
    return CharacterEntity(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      type: model.type,
      created: model.created,
      episodes: model.episode,
      gender: model.gender,
      image: model.image,
      url: model.url,
      location: LocationMapper.fromModel(model.location),
      origin: OriginMapper.fromModel(model.origin),
    );
  }

  static CharacterDbModel modelToDbModel(CharacterModel model) {
    return CharacterDbModel(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      type: model.type,
      created: model.created,
      episode: model.episodes,
      gender: model.gender,
      image: model.image,
      url: model.url,
      location: model.location,
      origin: model.origin,
    );
  }
}
