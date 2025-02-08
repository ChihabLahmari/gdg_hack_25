// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBody _$RegisterRequestBodyFromJson(Map<String, dynamic> json) =>
    RegisterRequestBody(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      goal: json['goal'] as String,
      profileImg: json['profileImg'] as String,
    );

Map<String, dynamic> _$RegisterRequestBodyToJson(
        RegisterRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'username': instance.username,
      'password': instance.password,
      'skills': instance.skills,
      'goal': instance.goal,
      'profileImg': instance.profileImg,
    };
