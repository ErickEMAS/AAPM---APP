// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerFieldModel _$SellerFieldModelFromJson(Map<String, dynamic> json) =>
    SellerFieldModel(
      id: json['id'] as String?,
      idDynamicSellerRef: json['idDynamicSellerRef'] as String?,
      name: json['name'] as String?,
      value: json['value'] as String?,
      type: $enumDecodeNullable(_$TypeFieldEnumMap, json['type']),
    );

Map<String, dynamic> _$SellerFieldModelToJson(SellerFieldModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idDynamicSellerRef': instance.idDynamicSellerRef,
      'name': instance.name,
      'value': instance.value,
      'type': _$TypeFieldEnumMap[instance.type],
    };

const _$TypeFieldEnumMap = {
  TypeField.TEXT: 'TEXT',
  TypeField.INT: 'INT',
};
