import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
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
    this.sellerFields,
    this.checkListVisitas,
    this.tags,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerModelToJson(this);

  static SellerModel fromJsonSheet(Map<String, dynamic> json) {
    SellerModel sm = SellerModel(
      cnpj: json[SellerField.cnpj],
      helenaSellerCode: json[SellerField.helenaSellerCode],
      nome: json[SellerField.nome],
      telefone: json[SellerField.telefone],
      email: json[SellerField.email],
      cidade: json[SellerField.cidade],
      uf: json[SellerField.uf],
      cep: json[SellerField.cep],
      endereco: json[SellerField.endereco],
      numero: json[SellerField.numero],
      complemento: json[SellerField.complemento],
      cadastro: json[SellerField.cadastro],
      dataPedidoTeste: json[SellerField.dataPedidoTeste],
    );

    return sm;
  }
}
