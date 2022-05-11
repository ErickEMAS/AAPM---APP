import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  String? id;
  String? email;
  String? fullName;
  String? password;
  String? passwordConfirm;
  String cpf;

  SignUpModel({
    this.id,
    required this.email,
    required this.cpf,
    required this.fullName,
    required this.password,
    required this.passwordConfirm,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
