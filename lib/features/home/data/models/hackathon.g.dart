// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hackathon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hackathon _$HackathonFromJson(Map<String, dynamic> json) => Hackathon(
      name: json['name'] as String,
      club: json['club'] as String,
      skillsRequired: (json['skillsRequired'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      level: json['level'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$HackathonToJson(Hackathon instance) => <String, dynamic>{
      'name': instance.name,
      'club': instance.club,
      'skillsRequired': instance.skillsRequired,
      'level': instance.level,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
