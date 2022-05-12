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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.all(8),
              color: AppColors.primary,
              child: Image.asset("assets/logo_splash.png"),
            ),
            !_store.admin ? _userHome(phoneWidth) : _adminHome(phoneWidth),
          ],
        ),
      ),
    );
  }

  Column _adminHome(double phoneWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeButton(
                onTap: () => _store.navigateToSellerFields(context),
                phoneWidth: phoneWidth,
                icon: Icons.dashboard_customize,
                title: "Campos Seller"),
            const SizedBox(width: 32),
            _homeButton(
                onTap: () => _store.navigateTocarteirasWithoutOwner(context),
                phoneWidth: phoneWidth,
                icon: Icons.account_balance_wallet,
                title: "Carteiras"),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeButton(
                onTap: () => _store.navigateToQuestionsChecklist(context),
                phoneWidth: phoneWidth,
                icon: Icons.checklist,
                title: "Questôes"),
            const SizedBox(width: 32),
            _homeButton(
                onTap: () => _store.navigateToAddagente(context),
                phoneWidth: phoneWidth,
                icon: Icons.person_add,
                title: "Novo Agente"),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Column _userHome(double phoneWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeButton(
                onTap: () => _store.navigateToMyTags(context),
                phoneWidth: phoneWidth,
                icon: Icons.bookmarks,
                title: "Minhas Tags"),
            const SizedBox(width: 32),
            _homeButton(
                onTap: () => _store.navigateToSellers(context),
                phoneWidth: phoneWidth,
                icon: Icons.credit_card,
                title: "Meus Sellers"),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeButton(
              onTap: () => _store.navigateToFAQ(context),
              phoneWidth: phoneWidth,
              icon: Icons.quiz,
              title: "Faq",
            ),
            const SizedBox(width: 32),
            _homeButton(
                onTap: () => _store.navigateToHunting(context),
                phoneWidth: phoneWidth,
                icon: Icons.store,
                title: "Meus Huntings"),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  _homeButton({
    required double phoneWidth,
    required IconData icon,
    required String title,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: () => {
        onTap(),
      },
      child: Container(
        height: 100,
        width: phoneWidth * .4,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: AppColors.primary,
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
      ),
    );
  }
}
