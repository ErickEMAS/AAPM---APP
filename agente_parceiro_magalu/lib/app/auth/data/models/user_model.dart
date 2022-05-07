import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  String? email;
  String cpf;
  String? fullName;
  bool emailConfirmed;
  List<String> roles;

  UserModel({
    required this.id,
    this.email,
    required this.cpf,
    this.fullName,
    required this.emailConfirmed,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
