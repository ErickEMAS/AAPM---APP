import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_code_model.g.dart';

@JsonSerializable()
class SendCode {
  String email;
  CodeType codeType;

  SendCode({
    required this.email,
    required this.codeType
  });

  factory SendCode.fromJson(Map<String, dynamic> json) =>
      _$SendCodeFromJson(json);

  Map<String, dynamic> toJson() => _$SendCodeToJson(this);
}
