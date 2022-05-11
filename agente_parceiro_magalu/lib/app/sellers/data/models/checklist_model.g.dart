// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChecklistModel _$ChecklistModelFromJson(Map<String, dynamic> json) =>
    ChecklistModel(
      id: json['id'] as String?,
      dataVisita: json['dataVisita'] == null
          ? null
          : DateTime.parse(json['dataVisita'] as String),
      nomeAgente: json['nomeAgente'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChecklistModelToJson(ChecklistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dataVisita': instance.dataVisita?.toIso8601String(),
      'nomeAgente': instance.nomeAgente,
      'questions': instance.questions,
    };
