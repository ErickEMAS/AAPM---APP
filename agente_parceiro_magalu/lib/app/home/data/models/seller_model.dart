import 'package:json_annotation/json_annotation.dart';

part 'seller_model.g.dart';

@JsonSerializable()
class SellerModel {
  String cnpj;
  String helenaSellerCode;
  String nome;
  String telefone;
  String email;
  String cidade;
  String uf;
  String cep;
  String endereco;
  String numero;
  String complemento;
  String cadastro;
  String dataPedidoTeste;

  SellerModel({
    required this.cnpj,
    required this.helenaSellerCode,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.cidade,
    required this.uf,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.complemento,
    required this.cadastro,
    required this.dataPedidoTeste,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerModelToJson(this);
}
