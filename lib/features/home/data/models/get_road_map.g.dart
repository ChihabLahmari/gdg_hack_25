// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_road_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoadMapRequest _$GetRoadMapRequestFromJson(Map<String, dynamic> json) =>
    GetRoadMapRequest(
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      goal: json['goal'] as String,
    );

Map<String, dynamic> _$GetRoadMapRequestToJson(GetRoadMapRequest instance) =>
    <String, dynamic>{
      'skills': instance.skills,
      'goal': instance.goal,
    };

GetRoadMapResponse _$GetRoadMapResponseFromJson(Map<String, dynamic> json) =>
    GetRoadMapResponse(
      roadMap: (json['roadMap'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$GetRoadMapResponseToJson(GetRoadMapResponse instance) =>
    <String, dynamic>{
      'roadMap': instance.roadMap,
    };
