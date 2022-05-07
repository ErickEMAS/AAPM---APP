import 'package:agente_parceiro_magalu/app/account/data/datasources/account_datasource.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/add_admin_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/add_agente_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/change_email_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/change_password_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/confirm_email_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/faq_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/my_tags_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/questions_checklist_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/seller_fields_store.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/user_detail_store.dart';
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
  serviceLocator.registerLazySingleton<IAccountDatasource>(
    () => AccountDatasource(),
  );
  serviceLocator.registerLazySingleton<UserDatailStore>(
    () => UserDatailStore(),
  );
  serviceLocator.registerLazySingleton<ConfirmEmailStore>(
    () => ConfirmEmailStore(),
  );
  serviceLocator.registerLazySingleton<ChangePasswordStore>(
    () => ChangePasswordStore(),
  );
  serviceLocator.registerLazySingleton<ChangeEmailStore>(
    () => ChangeEmailStore(),
  );
  serviceLocator.registerLazySingleton<AddAgenteStore>(
    () => AddAgenteStore(),
  );
  serviceLocator.registerLazySingleton<AddAdminStore>(
    () => AddAdminStore(),
  );
  serviceLocator.registerLazySingleton<SellerFieldsStore>(
    () => SellerFieldsStore(),
  );
  serviceLocator.registerLazySingleton<QuestionChecklistStore>(
    () => QuestionChecklistStore(),
  );
  serviceLocator.registerLazySingleton<MyTagsStore>(
    () => MyTagsStore(),
  );
  serviceLocator.registerLazySingleton<FAQStore>(
    () => FAQStore(),
  );
}
