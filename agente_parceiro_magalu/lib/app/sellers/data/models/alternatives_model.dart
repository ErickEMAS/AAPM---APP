import 'package:json_annotation/json_annotation.dart';

part 'alternatives_model.g.dart';

@JsonSerializable()
class AlternativesModel {
  String? id;
  String? tittle;

  AlternativesModel({
    this.id,
    required this.tittle,
  });

  factory AlternativesModel.fromJson(Map<String, dynamic> json) =>
      _$AlternativesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativesModelToJson(this);
}
