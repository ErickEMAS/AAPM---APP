import 'package:agente_parceiro_magalu/app/agent/data/models/carteira_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_agent_model.g.dart';

@JsonSerializable()
class UserAgentModel {
 String id;
  String? email;
  String cpf;
  String? fullName;
  bool? emailConfirmed;
  bool? accountNonLocked;
  bool? enabled;
  List<String> roles;
  CarteiraModel? carteira;

  UserAgentModel({
    this.email,
    this.carteira,
    this.fullName,
    this.enabled = false,
    this.emailConfirmed = false,
    this.accountNonLocked = false,
    required this.id,
    required this.cpf,
    required this.roles,
  });

  factory UserAgentModel.fromJson(Map<String, dynamic> json) =>
      _$UserAgentModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAgentModelToJson(this);
}

