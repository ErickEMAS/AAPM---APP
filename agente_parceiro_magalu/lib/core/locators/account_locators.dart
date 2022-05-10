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
import 'package:agente_parceiro_magalu/app/agent/data/datasources/agent_datasource.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

import '../../app/account/presentation/stores/carteiras_without_owner_store.dart';
import '../../app/account/presentation/stores/hunting_store.dart';

Future<void> setupAccountLocators() async {
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
  serviceLocator.registerLazySingleton<HuntingStore>(
    () => HuntingStore(),
  );
  serviceLocator.registerLazySingleton<CarteirasWithOwnerStore>(
    () => CarteirasWithOwnerStore(),
  );
}
