import 'package:agente_parceiro_magalu/app/agent/presentation/pages/agent_list_view.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/pages/view_agent_view.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/stores/user_agent_store.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({Key? key}) : super(key: key);

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
final UserAgentStore _store = serviceLocator<UserAgentStore>();

  @override
  void initState() {
    super.initState();
    _store.reset();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onUsersInit());
    });
  }

  @override
  void dispose() {
    _store.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: AppBarGradient(
            leading: _store.currentPage == 1
                ? BackButton(
                    onPressed: () => _store.previousPage(),
                  )
                : null,
            title: "Usuários",
          ),
          body: PageView.builder(
            clipBehavior: Clip.none,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            controller: _store.pageController,
            itemBuilder: (context, index) {
              return index == 0 ? const AgentListView() : const ViewAgentView();
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }
}
