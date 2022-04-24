// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      fullName: json['fullName'] as String,
      nickName: json['nickName'] as String,
      password: json['password'] as String,
      passwordConfirm: json['passwordConfirm'] as String,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'nickName': instance.nickName,
      'password': instance.password,
      'passwordConfirm': instance.passwordConfirm,
      'cpf': instance.cpf,
    };
