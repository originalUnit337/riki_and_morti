class LocationModel {
  final String name;

  const LocationModel({required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(name: map['name'],);
  }

  Map<String, dynamic> toJson(LocationModel val) => {
    'name': val.name,
  };
}
