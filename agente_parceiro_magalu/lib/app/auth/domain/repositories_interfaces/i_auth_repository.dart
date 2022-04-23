import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}
