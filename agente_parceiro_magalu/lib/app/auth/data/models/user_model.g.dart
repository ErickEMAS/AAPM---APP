// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      cpf: json['cpf'] as String,
      fullName: json['fullName'] as String?,
      emailIsConfirmed: json['emailIsConfirmed'] as bool,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'cpf': instance.cpf,
      'fullName': instance.fullName,
      'emailIsConfirmed': instance.emailIsConfirmed,
      'roles': instance.roles,
    };
