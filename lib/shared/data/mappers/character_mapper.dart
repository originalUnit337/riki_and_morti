import 'package:riki_and_morti/core/database/app_database.dart';
import 'package:riki_and_morti/shared/data/mappers/location_mapper.dart';
import 'package:riki_and_morti/shared/data/mappers/origin_mapper.dart';
import 'package:riki_and_morti/features/home/data/models/character_model.dart';
import 'package:riki_and_morti/shared/domain/entities/character_entity.dart';

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
      episode: model.episode,
      image: model.image, isFavourite: false,
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
      episode: model.episode,
      gender: model.gender,
      image: model.image,
      location: LocationMapper.fromModel(model.location),
      origin: OriginMapper.fromModel(model.origin),
      isFavourite: model.isFavourite,
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
      episode: model.episode,
      gender: model.gender,
      image: model.image,
      location: model.location,
      origin: model.origin,
      isFavourite: false,
    );
  }
}
