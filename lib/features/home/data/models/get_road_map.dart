import 'package:json_annotation/json_annotation.dart';

part 'get_road_map.g.dart';

@JsonSerializable()
class GetRoadMapRequest {
  final List<String> skills;
  final String goal;

  GetRoadMapRequest({
    required this.skills,
    required this.goal,
  });

  factory GetRoadMapRequest.fromJson(Map<String, dynamic> json) => _$GetRoadMapRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoadMapRequestToJson(this);
}

@JsonSerializable()
class GetRoadMapResponse {
  final Map<String, List<String>> roadMap;

  GetRoadMapResponse({
    required this.roadMap,
  });

  factory GetRoadMapResponse.fromJson(Map<String, dynamic> json) {
    return GetRoadMapResponse(
      roadMap: (json ?? {}).map<String, List<String>>((key, value) {
        if (value is List) {
          return MapEntry(key, value.whereType<String>().toList());
        }
        return MapEntry(key, []);
      }),
    );
  }

  Map<String, dynamic> toJson() => _$GetRoadMapResponseToJson(this);
}


