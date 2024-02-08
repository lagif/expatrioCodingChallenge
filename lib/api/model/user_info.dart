import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class UserInfo {
  String accessToken;
  @JsonKey(name: 'subject.email')
  String email;
  @JsonKey(name: 'subject.fullName')
  String name;
  DateTime accessTokenExpiresAt;
  @JsonKey(name: 'userId')
  int id;

  UserInfo({
    required this.name,
    required this.accessToken,
    required this.id,
    required this.accessTokenExpiresAt,
    required this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
