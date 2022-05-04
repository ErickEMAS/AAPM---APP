import 'package:agente_parceiro_magalu/app/home/presentation/stores/home_store.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _store = serviceLocator<HomeStore>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onHomeInit());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AppSafeArea(
          child: Scaffold(
            appBar: const AppBarGradient(
              automaticallyImplyLeading: false,
              title: "home page",
            ),
            bottomNavigationBar: AppBottomBar(),
          ),
        );
      },
    );
  }
}
