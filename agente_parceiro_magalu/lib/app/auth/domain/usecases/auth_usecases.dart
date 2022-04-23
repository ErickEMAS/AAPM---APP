import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/repositories_interfaces/i_auth_repository.dart';

abstract class IAuthUseCase {
  Future<UserModel> login({
    required String email,
    required String password,
  });
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
}
