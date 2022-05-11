import 'package:agente_parceiro_magalu/app/agent/data/datasources/agent_datasource.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

import '../../app/agent/presentation/stores/user_agent_store.dart';

Future<void> setupAgentLocators() async {
  serviceLocator.registerLazySingleton<IAgentDatasource>(
    () => AgentDatasource(),
  );
  serviceLocator.registerLazySingleton<UserAgentStore>(
    () => UserAgentStore(),
  );
}
