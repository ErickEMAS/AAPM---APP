import 'package:json_annotation/json_annotation.dart';

part 'hunting_model.g.dart';

@JsonSerializable()
class HuntingModel {
  String? id;
  String? nome;
  String? telefone;
  String? email;
  String? cidade;
  String? uf;
  String? cep;
  String? endereco;
  String? numero;
  String? complemento;

  HuntingModel({
    this.id,
    this.nome,
    this.telefone,
    this.email,
    this.cidade,
    this.uf,
    this.cep,
    this.endereco,
    this.numero,
    this.complemento,
  });

  factory HuntingModel.fromJson(Map<String, dynamic> json) =>
      _$HuntingModelFromJson(json);

  Map<String, dynamic> toJson() => _$HuntingModelToJson(this);
}

