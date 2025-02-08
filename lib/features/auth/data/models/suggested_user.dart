import 'package:json_annotation/json_annotation.dart';

part 'suggested_user.g.dart';

@JsonSerializable()
class SuggestedUser {
  final String profileImg;
  final String username;
  final String skills;
  final int score;

  SuggestedUser({
    required this.profileImg,
    required this.username,
    required this.skills,
    required this.score,
  });

  factory SuggestedUser.fromJson(Map<String, dynamic> json) => _$SuggestedUserFromJson(json);


  Map<String, dynamic> toJson() => _$SuggestedUserToJson(this);
}
