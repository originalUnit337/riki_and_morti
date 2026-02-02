class OriginModel {
  final String name;

  OriginModel({required this.name});

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'name': name};
}
