// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerModel _$SellerModelFromJson(Map<String, dynamic> json) => SellerModel(
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
      cadastro: json['cadastro'] as String,
      dataPedidoTeste: json['dataPedidoTeste'] as String,
    );

Map<String, dynamic> _$SellerModelToJson(SellerModel instance) =>
    <String, dynamic>{
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
      'cadastro': instance.cadastro,
      'dataPedidoTeste': instance.dataPedidoTeste,
    };
