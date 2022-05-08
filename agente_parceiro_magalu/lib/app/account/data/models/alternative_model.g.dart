// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternative_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlternativeModel _$AlternativeModelFromJson(Map<String, dynamic> json) =>
    AlternativeModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      checked: json['checked'] as bool,
    );

Map<String, dynamic> _$AlternativeModelToJson(AlternativeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'checked': instance.checked,
    };
