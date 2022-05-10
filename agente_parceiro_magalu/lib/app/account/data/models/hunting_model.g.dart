// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hunting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HuntingModel _$HuntingModelFromJson(Map<String, dynamic> json) => HuntingModel(
      id: json['id'] as String?,
      nome: json['nome'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      cidade: json['cidade'] as String?,
      uf: json['uf'] as String?,
      cep: json['cep'] as String?,
      endereco: json['endereco'] as String?,
      numero: json['numero'] as String?,
      complemento: json['complemento'] as String?,
    );

Map<String, dynamic> _$HuntingModelToJson(HuntingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'telefone': instance.telefone,
      'email': instance.email,
      'cidade': instance.cidade,
      'uf': instance.uf,
      'cep': instance.cep,
      'endereco': instance.endereco,
      'numero': instance.numero,
      'complemento': instance.complemento,
    };
