// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_question_checkList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicQuestionCheckListModel _$DynamicQuestionCheckListModelFromJson(
        Map<String, dynamic> json) =>
    DynamicQuestionCheckListModel(
      id: json['id'] as String?,
      question: json['question'] as String,
      answerRequired: json['answerRequired'] as bool? ?? false,
      multipleAlternative: json['multipleAlternative'] as bool? ?? false,
      active: json['active'] as bool? ?? false,
      fieldUpdate: DynamicFieldModel.fromJson(
          json['fieldUpdate'] as Map<String, dynamic>),
      alternatives: (json['alternatives'] as List<dynamic>)
          .map((e) => AlternativeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DynamicQuestionCheckListModelToJson(
        DynamicQuestionCheckListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answerRequired': instance.answerRequired,
      'multipleAlternative': instance.multipleAlternative,
      'active': instance.active,
      'fieldUpdate': instance.fieldUpdate,
      'alternatives': instance.alternatives,
    };
