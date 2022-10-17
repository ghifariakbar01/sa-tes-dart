import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Users {
  @JsonKey(name: 'created_date')
  String? createdDate;
  String? email;
  String? password;
  String? username;

  Users(
      {required this.createdDate,
      required this.email,
      this.password,
      this.username});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
