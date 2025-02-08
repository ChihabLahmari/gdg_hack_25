import 'package:json_annotation/json_annotation.dart';
import 'package:my_template/features/auth/data/models/user.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  final String title;
  final String description;
  final List<User> members;
  final User mentor;
  final String startDate;
  final String endData;
  final List<String> resources;

  Project({
    required this.title,
    required this.description,
    required this.members,
    required this.mentor,
    required this.startDate,
    required this.endData,
    required this.resources,
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
