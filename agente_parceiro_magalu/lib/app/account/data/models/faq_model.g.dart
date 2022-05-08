// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQModel _$FAQModelFromJson(Map<String, dynamic> json) => FAQModel(
      id: json['id'] as String?,
      question: json['question'] as String,
      answer: json['answer'] as String,
      open: json['open'] as bool? ?? false,
    );

Map<String, dynamic> _$FAQModelToJson(FAQModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'open': instance.open,
    };
