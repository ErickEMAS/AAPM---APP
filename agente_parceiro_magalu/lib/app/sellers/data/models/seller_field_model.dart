import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_field_model.g.dart';

@JsonSerializable()
class SellerFieldModel {
  String? id;
  String? idDynamicSellerRef;
  String? name;
  String? value;
  TypeField? type;

  SellerFieldModel({
    this.id,
    this.idDynamicSellerRef,
    this.name,
    this.value,
    this.type,
  });

  factory SellerFieldModel.fromJson(Map<String, dynamic> json) =>
      _$SellerFieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerFieldModelToJson(this);
}
