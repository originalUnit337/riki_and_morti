import 'package:riki_and_morti/core/database/location_model.dart';
import 'package:riki_and_morti/core/database/origin_model.dart';

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginModel origin;
  final LocationModel location;
  final String image;
  final List<String> episode;
  final DateTime created;

  CharacterModel({
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
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: int.parse(json['id']),
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      created: DateTime.parse(json['created']),
      episode: (json['episode'] as List)
          .map((e) => e['episode'] as String)
          .toList(),
      gender: json['gender'],
      image: json['image'],
      origin: OriginModel.fromJson(json['origin']),
      location: LocationModel.fromJson(json['location']),
    );
  }
}
