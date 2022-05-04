import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_model.g.dart';

@JsonSerializable()
class SellerModel {
  String? id;
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
  List? sellerFields;
  List? checkListVisitas;
  List<TagModel>? tags;

  SellerModel({
    this.id,
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
    this.sellerFields,
    this.checkListVisitas,
    this.tags,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerModelToJson(this);
}
