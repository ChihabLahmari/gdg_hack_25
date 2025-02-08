// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filed_desc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      name: json['name'] as String,
      url: json['url'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
    };

FieldDescription _$FieldDescriptionFromJson(Map<String, dynamic> json) =>
    FieldDescription(
      description: json['description'] as String,
      resources: (json['resources'] as List<dynamic>)
          .map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FieldDescriptionToJson(FieldDescription instance) =>
    <String, dynamic>{
      'description': instance.description,
      'resources': instance.resources,
    };
