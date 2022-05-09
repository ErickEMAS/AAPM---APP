// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as String?,
      question: json['question'] as String?,
      alternatives: (json['alternatives'] as List<dynamic>?)
          ?.map((e) => AlternativeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      answerRequired: json['answerRequired'] as bool?,
      fieldUpdateId: json['fieldUpdateID'] as String?,
      multipleAlternative: json['multipleAlternative'] as bool?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fieldUpdateID': instance.fieldUpdateId,
      'question': instance.question,
      'answerRequired': instance.answerRequired,
      'multipleAlternative': instance.multipleAlternative,
      'alternatives': instance.alternatives,
    };
