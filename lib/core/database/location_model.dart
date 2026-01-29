class LocationModel {
  final String name;
  final String url;

  const LocationModel({required this.name, required this.url});

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(name: map['name'], url: map['url']);
  }

  Map<String, dynamic> toJson(LocationModel val) => {
    'name': val.name,
    'url': val.url,
  };
}
