// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestedUser _$SuggestedUserFromJson(Map<String, dynamic> json) =>
    SuggestedUser(
      profileImg: json['profileImg'] as String,
      username: json['username'] as String,
      skills: json['skills'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$SuggestedUserToJson(SuggestedUser instance) =>
    <String, dynamic>{
      'profileImg': instance.profileImg,
      'username': instance.username,
      'skills': instance.skills,
      'score': instance.score,
    };
