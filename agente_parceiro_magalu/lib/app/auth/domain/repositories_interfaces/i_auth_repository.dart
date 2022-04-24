import 'package:agente_parceiro_magalu/app/auth/data/models/send_code_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';

abstract class IAuthRepository {
  Future<UserModel> login({required String email, required String password});
  Future verifyCpf({required String cpf});
  Future signUp({required SignUpModel signUpModel});
  Future sendCode({required SendCode sendCode});
}
