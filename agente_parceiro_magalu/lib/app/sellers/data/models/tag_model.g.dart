// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      color: $enumDecode(_$TagColorsEnumMap, json['color']),
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': _$TagColorsEnumMap[instance.color],
    };

const _$TagColorsEnumMap = {
  TagColors.amarelo: 'amarelo',
  TagColors.laranja: 'laranja',
  TagColors.rosa: 'rosa',
  TagColors.roxo: 'roxo',
  TagColors.azul: 'azul',
  TagColors.verde: 'verde',
};
