import 'package:json_annotation/json_annotation.dart';

part 'alternatives_model.g.dart';

@JsonSerializable()
class AlternativesModel {
  String? id;
  @JsonKey(name: 'tittle')
  String? title;

  AlternativesModel({
    this.id,
    required this.title,
  });

  factory AlternativesModel.fromJson(Map<String, dynamic> json) =>
      _$AlternativesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativesModelToJson(this);
}
