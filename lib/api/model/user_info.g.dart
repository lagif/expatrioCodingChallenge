// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      name: json['subject.fullName'] as String,
      accessToken: json['accessToken'] as String,
      id: json['userId'] as int,
      accessTokenExpiresAt:
          DateTime.parse(json['accessTokenExpiresAt'] as String),
      email: json['subject.email'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'subject.email': instance.email,
      'subject.fullName': instance.name,
      'accessTokenExpiresAt': instance.accessTokenExpiresAt.toIso8601String(),
      'userId': instance.id,
    };
