import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_model.g.dart';

@JsonSerializable()
class ChecklistModel {
  String? id;
  DateTime? dataVisita;
  String? nomeAgente;
  List<QuestionModel>? questions;

  ChecklistModel({
    this.id,
    this.dataVisita,
    this.nomeAgente,
    this.questions,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) =>
      _$ChecklistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistModelToJson(this);
}
