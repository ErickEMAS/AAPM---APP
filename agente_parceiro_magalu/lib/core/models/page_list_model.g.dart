// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageListModel _$PageListModelFromJson(Map<String, dynamic> json) =>
    PageListModel(
      totalPages: json['totalPages'] as int? ?? -1,
      totalElements: json['totalElements'] as int? ?? -1,
      numberOfElements: json['numberOfElements'] as int? ?? -1,
      size: json['size'] as int? ?? -1,
      number: json['number'] as int? ?? -1,
      first: json['first'] as bool? ?? false,
      last: json['last'] as bool? ?? false,
      empty: json['empty'] as bool? ?? false,
    )..content = json['content'] as List<dynamic>;

Map<String, dynamic> _$PageListModelToJson(PageListModel instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'numberOfElements': instance.numberOfElements,
      'size': instance.size,
      'number': instance.number,
      'last': instance.last,
      'first': instance.first,
      'empty': instance.empty,
      'content': instance.content,
    };
