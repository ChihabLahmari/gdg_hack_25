// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'hackathon.g.dart'; // This is the part directive that connects to the generated file.

@JsonSerializable()
class Hackathon {
  final String name;
  final String club;
  final List<String> skillsRequired;
  final String level;
  final String startDate;
  final String endDate;

  Hackathon({
    required this.name,
    required this.club,
    required this.skillsRequired,
    required this.level,
    required this.startDate,
    required this.endDate,
  });

  factory Hackathon.fromJson(Map<String, dynamic> json) => _$HackathonFromJson(json);

  Map<String, dynamic> toJson() => _$HackathonToJson(this);
}
