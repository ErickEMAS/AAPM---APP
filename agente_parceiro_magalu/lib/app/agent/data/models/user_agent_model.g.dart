// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_agent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAgentModel _$UserAgentModelFromJson(Map<String, dynamic> json) =>
    UserAgentModel(
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      enabled: json['enabled'] as bool? ?? false,
      emailConfirmed: json['emailConfirmed'] as bool? ?? false,
      accountNonLocked: json['accountNonLocked'] as bool? ?? false,
      id: json['id'] as String,
      cpf: json['cpf'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      totalSeller: json['totalSeller'] as int,
    );

Map<String, dynamic> _$UserAgentModelToJson(UserAgentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'cpf': instance.cpf,
      'fullName': instance.fullName,
      'emailConfirmed': instance.emailConfirmed,
      'accountNonLocked': instance.accountNonLocked,
      'enabled': instance.enabled,
      'roles': instance.roles,
      'totalSeller': instance.totalSeller,
    };
