import 'package:agente_parceiro_magalu/app/home/presentation/stores/home_store.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/themes/app_colors.dart';

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
    double phoneWidth = MediaQuery.of(context).size.width;

    return AppSafeArea(
      child: Scaffold(
        appBar: const AppBarGradient(
          automaticallyImplyLeading: false,
          title: "home page",
        ),
        bottomNavigationBar: AppBottomBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 400,
              width: phoneWidth * .87,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: Image.asset("assets/logo_splash.png"),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _homeButton(
                        phoneWidth: phoneWidth,
                        icon: Icons.home,
                        title: "Meus Sellers"),
                    const SizedBox(width: 32),
                    _homeButton(
                        phoneWidth: phoneWidth,
                        icon: Icons.home,
                        title: "Meus Sellers"),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _homeButton(
                        phoneWidth: phoneWidth,
                        icon: Icons.home,
                        title: "Meus Sellers"),
                    const SizedBox(width: 32),
                    _homeButton(
                        phoneWidth: phoneWidth,
                        icon: Icons.home,
                        title: "Meus Sellers"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _homeButton(
      {required double phoneWidth,
      required IconData icon,
      required String title}) {
    return Container(
      height: 100,
      width: phoneWidth * .4,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(color: AppColors.grey, spreadRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 32,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
