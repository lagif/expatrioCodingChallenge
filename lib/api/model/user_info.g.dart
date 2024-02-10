// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      subject: UserSubject.fromJson(json['subject'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      id: json['userId'] as int,
      accessTokenExpiresAt:
          DateTime.parse(json['accessTokenExpiresAt'] as String),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'subject': instance.subject.toJson(),
      'accessTokenExpiresAt': instance.accessTokenExpiresAt.toIso8601String(),
      'userId': instance.id,
    };

UserSubject _$UserSubjectFromJson(Map<String, dynamic> json) => UserSubject(
      name: json['fullName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserSubjectToJson(UserSubject instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.name,
    };
