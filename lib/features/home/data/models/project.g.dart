// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      title: json['title'] as String,
      description: json['description'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      mentor: User.fromJson(json['mentor'] as Map<String, dynamic>),
      startDate: json['startDate'] as String,
      endData: json['endData'] as String,
      resources:
          (json['resources'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'members': instance.members,
      'mentor': instance.mentor,
      'startDate': instance.startDate,
      'endData': instance.endData,
      'resources': instance.resources,
    };
