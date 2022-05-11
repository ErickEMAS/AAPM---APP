import 'package:agente_parceiro_magalu/app/sellers/data/models/alternatives_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  String? id;
  @JsonKey(name: "fieldUpdateID")
  String? fieldUpdateId;
  String? question;
  bool? answerRequired;
  bool? multipleAlternative;
  List<AlternativeModel>? alternatives;

  QuestionModel({
    this.id,
    this.question,
    this.alternatives,
    this.answerRequired,
    this.fieldUpdateId,
    this.multipleAlternative,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
