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
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChecklistModelToJson(ChecklistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dataVisita': instance.dataVisita?.toIso8601String(),
      'questions': instance.questions,
    };
