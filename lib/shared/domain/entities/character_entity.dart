import 'package:riki_and_morti/shared/domain/entities/location_entity.dart';
import 'package:riki_and_morti/shared/domain/entities/origin_entity.dart';

class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final DateTime created;
  final bool isFavourite;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
    required this.isFavourite,
  });

  CharacterEntity copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    OriginEntity? origin,
    LocationEntity? location,
    String? image,
    List<String>? episode,
    DateTime? created,
    bool? isFavourite,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      created: created ?? this.created,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
