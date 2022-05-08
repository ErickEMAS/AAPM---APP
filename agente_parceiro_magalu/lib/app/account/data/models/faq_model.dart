import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FAQModel {
  String? id;
  String question;
  String answer;
  bool open;

  FAQModel({
    this.id,
    required this.question,
    required this.answer,
    this.open = false,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) =>
      _$FAQModelFromJson(json);

  Map<String, dynamic> toJson() => _$FAQModelToJson(this);
}

