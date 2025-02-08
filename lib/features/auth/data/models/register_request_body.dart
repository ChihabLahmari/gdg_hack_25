import 'package:json_annotation/json_annotation.dart';
part 'register_request_body.g.dart';


@JsonSerializable()
class RegisterRequestBody {
  final String email;
  final String fullName;
  final String username;
  final String password;
  List<String> skills = [];
  final String goal;
  final String profileImg;

  RegisterRequestBody({
    required this.email,
    required this.fullName,
    required this.username,
    required this.password,
    required this.skills,
    required this.goal,
    required this.profileImg,
  });

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) => _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);

}
