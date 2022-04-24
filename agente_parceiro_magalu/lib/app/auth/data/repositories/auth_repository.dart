import 'package:agente_parceiro_magalu/app/auth/data/datasource/auth_datasource.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/repositories_interfaces/i_auth_repository.dart';

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
}
