// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerModel _$SellerModelFromJson(Map<String, dynamic> json) => SellerModel(
      id: json['id'] as String?,
      cnpj: json['cnpj'] as String,
      helenaSellerCode: json['helenaSellerCode'] as String,
      nome: json['nome'] as String,
      telefone: json['telefone'] as String,
      email: json['email'] as String,
      cidade: json['cidade'] as String,
      uf: json['uf'] as String,
      cep: json['cep'] as String,
      endereco: json['endereco'] as String,
      numero: json['numero'] as String,
      complemento: json['complemento'] as String,
      orderVisitItinerary: json['orderVisitItinerary'] as int? ?? 0,
      visiting: json['visiting'] as bool? ?? false,
      sellerFields: json['sellerFields'] as List<dynamic>?,
      checkListVisitas: json['checkListVisitas'] as List<dynamic>?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SellerModelToJson(SellerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cnpj': instance.cnpj,
      'helenaSellerCode': instance.helenaSellerCode,
      'nome': instance.nome,
      'telefone': instance.telefone,
      'email': instance.email,
      'cidade': instance.cidade,
      'uf': instance.uf,
      'cep': instance.cep,
      'endereco': instance.endereco,
      'numero': instance.numero,
      'complemento': instance.complemento,
      'orderVisitItinerary': instance.orderVisitItinerary,
      'visiting': instance.visiting,
      'sellerFields': instance.sellerFields,
      'checkListVisitas': instance.checkListVisitas,
      'tags': instance.tags,
    };
