import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dynamic_field_model.g.dart';

@JsonSerializable()
class DynamicFieldModel {
  String? id;
  String name;
  TypeField type;

  DynamicFieldModel({
    this.id,
    required this.name,
    required this.type,
  });

  factory DynamicFieldModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicFieldModelToJson(this);
}

