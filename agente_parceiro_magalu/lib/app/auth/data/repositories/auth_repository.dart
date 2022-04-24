import 'dart:math';

import 'package:agente_parceiro_magalu/app/auth/data/datasource/auth_datasource.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/send_code_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/repositories_interfaces/i_auth_repository.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource _datasource;

  AuthRepository(this._datasource);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) {
    return _datasource.login(email: email, password: password);
  }

  @override
  Future verifyCpf({required String cpf}) {
    return _datasource.verifyCpf(cpf: cpf);
  }

  @override
  Future signUp({required SignUpModel signUpModel}) {
    return _datasource.signUp(signUpModel: signUpModel);
  }

  @override
  Future sendCode({required SendCode sendCode}) {
    return _datasource.sendCode(sendCode: sendCode);
  }

  @override
  Future confirmeCode({required String email, required String code}) {
    return _datasource.confirmeCode(email: email, code: code);
  }

  @override
  Future changePassword({required ChangePassword changePassword}) {
    return _datasource.changePassword(changePassword: changePassword);
  }
}
