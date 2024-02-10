import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class UserInfo {
  String accessToken;
  UserSubject subject;
  DateTime accessTokenExpiresAt;
  @JsonKey(name: 'userId')
  int id;

  UserInfo({
    required this.subject,
    required this.accessToken,
    required this.id,
    required this.accessTokenExpiresAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class UserSubject {
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'fullName')
  String name;

  UserSubject({
    required this.name,
    required this.email,
  });

  factory UserSubject.fromJson(Map<String, dynamic> json) =>
      _$UserSubjectFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubjectToJson(this);
}
