import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/send_code_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';

abstract class IAuthRepository {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> verifyCpf({required String cpf});
  Future signUp({required SignUpModel signUpModel});
  Future sendCode({required SendCode sendCode});
  Future confirmeCode({required String email, required String code});
  Future changePassword({required ChangePassword changePassword});
  Future confirmeEmail({required String email, required String code});
}
