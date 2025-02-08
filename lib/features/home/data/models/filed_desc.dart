import 'package:json_annotation/json_annotation.dart';

part 'filed_desc.g.dart';

@JsonSerializable()
class Resource {
  final String name;
  final String url;
  final String type;

  Resource({
    required this.name,
    required this.url,
    required this.type,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}

@JsonSerializable()
class FieldDescription {
  final String description;
  final List<Resource> resources;

  FieldDescription({
    required this.description,
    required this.resources,
  });

  factory FieldDescription.fromJson(Map<String, dynamic> json) {
    var resourcesJson = json['details']['resources'] as List<dynamic>?;
    List<Resource> resourcesList = resourcesJson?.map((resource) => Resource.fromJson(resource)).toList() ?? [];

    return FieldDescription(
      description: json['details']['description'] ?? "No description available",
      resources: resourcesList,
    );
  }

  Map<String, dynamic> toJson() => _$FieldDescriptionToJson(this);
}