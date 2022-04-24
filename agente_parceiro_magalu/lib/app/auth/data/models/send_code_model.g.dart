// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCode _$SendCodeFromJson(Map<String, dynamic> json) => SendCode(
      email: json['email'] as String,
      codeType: $enumDecode(_$CodeTypeEnumMap, json['codeType']),
    );

Map<String, dynamic> _$SendCodeToJson(SendCode instance) => <String, dynamic>{
      'email': instance.email,
      'codeType': _$CodeTypeEnumMap[instance.codeType],
    };

const _$CodeTypeEnumMap = {
  CodeType.EMAIL_CONFIRM: 'EMAIL_CONFIRM',
  CodeType.EMAIL_CHANGE: 'EMAIL_CHANGE',
  CodeType.PASSWORD_CHANGE: 'PASSWORD_CHANGE',
};
