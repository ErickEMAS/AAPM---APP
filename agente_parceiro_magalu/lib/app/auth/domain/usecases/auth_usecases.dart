import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/send_code_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/repositories_interfaces/i_auth_repository.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';

abstract class IAuthUseCase {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future verifyCpf({required String cpf});
  Future signUp({required SignUpModel signUpModel});
  Future forgotPassWordSendCode({required String email});
  Future forgotPassWordConfirmeCode({required String email, required String code});
  Future forgotPassWordChangePassword({required ChangePassword changePassword});
}

class AuthUseCase implements IAuthUseCase {
  final IAuthRepository _repository;

  AuthUseCase(this._repository);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await _repository.login(email: email, password: password);
      return response;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<UserModel> verifyCpf({
    required String cpf,
  }) async {
    try {
      final response = await _repository.verifyCpf(cpf: cpf);
      return response;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({required SignUpModel signUpModel}) async {
    try {
      final response = await _repository.signUp(signUpModel: signUpModel);
      return response;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future forgotPassWordSendCode({
    required String email,
  }) async {
    try {
      final response =
          await _repository.sendCode(sendCode: SendCode(email: email, codeType: CodeType.PASSWORD_CHANGE));
      return response;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future forgotPassWordConfirmeCode({required String email, required String code}) async {
    try {
      final response =
          await _repository.confirmeCode(email: email, code: code);
      return response;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future forgotPassWordChangePassword({required ChangePassword changePassword}) async {
     try {
      final response =
          await _repository.changePassword(changePassword: changePassword);
      return response;
    } catch (err) {
      rethrow;
    }
  }
}
