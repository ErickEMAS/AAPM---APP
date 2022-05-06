import 'package:agente_parceiro_magalu/app/sellers/data/models/alternatives_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionsModel {
  String? id;
  String? question;
  List<AlternativesModel>? alternatives;
  bool? answerRequired;
  bool? active;
  String? fieldUpdateId;

  QuestionsModel({
    this.id,
    this.question,
    this.alternatives,
    this.answerRequired,
    this.active,
    this.fieldUpdateId,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsModelToJson(this);
}
