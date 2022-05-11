import 'package:agente_parceiro_magalu/app/account/data/models/alternative_model.dart';
import 'package:agente_parceiro_magalu/app/account/data/models/dynamic_field_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dynamic_question_checkList_model.g.dart';

@JsonSerializable()
class DynamicQuestionCheckListModel {
  String? id;
  String question;
  bool answerRequired;
  bool multipleAlternative;
  bool active;
  DynamicFieldModel fieldUpdate;
  List<AlternativeModel> alternatives;

  DynamicQuestionCheckListModel({
    this.id,
    required this.question,
    this.answerRequired = false,
    this.multipleAlternative = false,
    this.active = false,
    required this.fieldUpdate,
    required this.alternatives,
  });

  factory DynamicQuestionCheckListModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicQuestionCheckListModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicQuestionCheckListModelToJson(this);
}
