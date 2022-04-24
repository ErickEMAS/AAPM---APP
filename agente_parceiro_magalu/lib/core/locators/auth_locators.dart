import 'package:agente_parceiro_magalu/app/auth/data/datasource/auth_datasource.dart';
import 'package:agente_parceiro_magalu/app/auth/data/repositories/auth_repository.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/repositories_interfaces/i_auth_repository.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/usecases/auth_usecases.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/stores/forgot_password_store.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/stores/login_store.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/stores/sign_up_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

Future<void> setupAuthLocators() async {
  serviceLocator.registerLazySingleton<IAuthDatasource>(
    () => AuthDatasource(),
  );
  serviceLocator.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(serviceLocator<IAuthDatasource>()),
  );
  serviceLocator.registerLazySingleton<IAuthUseCase>(
    () => AuthUseCase(serviceLocator<IAuthRepository>()),
  );
  serviceLocator.registerLazySingleton<LoginStore>(
    () => LoginStore(),
  );
  serviceLocator.registerLazySingleton<ForgotPassWordStore>(
    () => ForgotPassWordStore(),
  );
  serviceLocator.registerLazySingleton<SignUpStore>(
    () => SignUpStore(),
  );
}
