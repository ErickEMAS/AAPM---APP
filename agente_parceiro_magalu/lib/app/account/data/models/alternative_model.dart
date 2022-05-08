import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alternative_model.g.dart';

@JsonSerializable()
class AlternativeModel {
  String? id;
  String name;
  bool checked = false;

  AlternativeModel({
    this.id,
    required this.name,
    required this.checked,
  });

  factory AlternativeModel.fromJson(Map<String, dynamic> json) =>
      _$AlternativeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeModelToJson(this);
}

