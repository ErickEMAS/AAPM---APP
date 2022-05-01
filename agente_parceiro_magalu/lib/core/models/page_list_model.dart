import 'package:json_annotation/json_annotation.dart';
part 'page_list_model.g.dart';

@JsonSerializable()
class PageListModel {
  int totalPages;
  int totalElements;
  int numberOfElements;
  int size;
  int number;
  bool last;
  bool first;
  bool empty;

  List content = [];

  PageListModel({
    this.totalPages = -1,
    this.totalElements = -1,
    this.numberOfElements = -1,
    this.size = -1,
    this.number = -1,
    this.first = false,
    this.last = false,
    this.empty = false,
  });

  factory PageListModel.fromJson(Map<String, dynamic> json) =>
      _$PageListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageListModelToJson(this);

  // static PageListModel fromJson(Map<String, dynamic> json) {
  //   final obj = PageListModel(
  //     totalPages: json["totalPages"] ?? -1,
  //     totalElements: json["totalElements"] ?? -1,
  //     numberOfElements: json["numberOfElements"] ?? -1,
  //     size: json["size"] ?? -1,
  //     number: json["number"] ?? -1,
  //     first: json["first"] ?? false,
  //     last: json["last"] ?? false,
  //     empty: json["empty"] ?? false,
  //   );

  //   return obj;
  // }
}
