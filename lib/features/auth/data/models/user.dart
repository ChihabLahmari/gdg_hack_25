import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String id;
  final String email;
  final String fullName;
  final String username;
  List<String> skills = [];
  final String goal;
  final String profileImg;
  @JsonKey(defaultValue: {})
  Map<String, dynamic> roadmap;
  @JsonKey(defaultValue: false)
  final bool isAdmin;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.username,
    required this.skills,
    required this.goal,
    required this.profileImg,
    this.roadmap = const {},
    this.isAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
