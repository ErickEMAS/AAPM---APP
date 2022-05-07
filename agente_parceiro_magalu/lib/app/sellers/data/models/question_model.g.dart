// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsModel _$QuestionsModelFromJson(Map<String, dynamic> json) =>
    QuestionsModel(
      id: json['id'] as String?,
      question: json['question'] as String?,
      alternatives: (json['alternatives'] as List<dynamic>?)
          ?.map((e) => AlternativesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      answerRequired: json['answerRequired'] as bool?,
      active: json['active'] as bool?,
      fieldUpdateId: json['fieldUpdateID'] as String?,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$QuestionsModelToJson(QuestionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'alternatives': instance.alternatives,
      'answerRequired': instance.answerRequired,
      'active': instance.active,
      'fieldUpdateID': instance.fieldUpdateId,
      'answer': instance.answer,
    };
