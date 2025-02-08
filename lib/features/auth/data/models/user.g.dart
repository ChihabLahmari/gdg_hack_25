// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      goal: json['goal'] as String,
      profileImg: json['profileImg'] as String,
      roadmap: json['roadmap'] as Map<String, dynamic>? ?? {},
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'username': instance.username,
      'skills': instance.skills,
      'goal': instance.goal,
      'profileImg': instance.profileImg,
      'roadmap': instance.roadmap,
      'isAdmin': instance.isAdmin,
    };
