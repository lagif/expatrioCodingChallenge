// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['emailAddress'] as String,
      lastName: json['lastName'] as String,
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'title': instance.title,
      'emailAddress': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'id': instance.id,
    };
