// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicFieldModel _$DynamicFieldModelFromJson(Map<String, dynamic> json) =>
    DynamicFieldModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      type: $enumDecode(_$TypeFieldEnumMap, json['type']),
    );

Map<String, dynamic> _$DynamicFieldModelToJson(DynamicFieldModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$TypeFieldEnumMap[instance.type],
    };

const _$TypeFieldEnumMap = {
  TypeField.TEXT: 'TEXT',
  TypeField.INT: 'INT',
};
