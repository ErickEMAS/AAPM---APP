import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carteira_model.g.dart';

@JsonSerializable()
class CarteiraModel {
 String id;
  List<SellerModel>? sellers;

  CarteiraModel({
    required this.id,
    this.sellers,
  });

  factory CarteiraModel.fromJson(Map<String, dynamic> json) =>
      _$CarteiraModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarteiraModelToJson(this);
}

