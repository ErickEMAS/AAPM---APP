import 'package:json_annotation/json_annotation.dart';

part 'alternatives_model.g.dart';

@JsonSerializable()
class AlternativeModel {
  String? id;
  String? name;
  bool checked;

  AlternativeModel({
    this.id,
    required this.name,
    this.checked = false,
  });

  factory AlternativeModel.fromJson(Map<String, dynamic> json) =>
      _$AlternativeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeModelToJson(this);
}
