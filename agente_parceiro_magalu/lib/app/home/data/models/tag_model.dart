import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  String? id;
  String name;
  TagColors color;

  TagModel({
    this.id,
    required this.name,
    required this.color,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
