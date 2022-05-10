// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarteiraModel _$CarteiraModelFromJson(Map<String, dynamic> json) =>
    CarteiraModel(
      id: json['id'] as String,
      sellers: (json['sellers'] as List<dynamic>?)
          ?.map((e) => SellerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarteiraModelToJson(CarteiraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sellers': instance.sellers,
    };
