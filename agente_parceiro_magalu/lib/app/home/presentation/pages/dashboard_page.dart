import 'package:agente_parceiro_magalu/app/home/presentation/stores/dasboard_store.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardStore _store = DashboardStore();

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _logo(),
            _inputs(),
          ],
        ),
      ),
    );
  }

  _logo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: AppColors.primary,
      child: Center(
        child: Image.asset(
          "assets/logo_splash.png",
          scale: 2,
        ),
      ),
    );
  }

  _inputs() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Entrar"),
                onPressed: () {
                  _store.navigateToLogin(context);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: const Text("Criar conta"),
                onPressed: () {
                  _store.navigateToSignUp(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
