import 'package:json_annotation/json_annotation.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePassword {
  String email;
  String code;
  String password;
  String passwordConfirm;

  ChangePassword(
      {required this.email,
      required this.code,
      required this.password,
      required this.passwordConfirm});

  factory ChangePassword.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordToJson(this);
}
