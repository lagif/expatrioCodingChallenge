import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class User {
  String title;
  @JsonKey(name: 'emailAddress')
  String email;
  String firstName;
  String lastName;
  int id;

  User({
    required this.email,
    required this.lastName,
    required this.id,
    required this.firstName,
    required this.title,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
