import 'package:agente_parceiro_magalu/app/auth/presentation/stores/login_store.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore _store = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Login",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Digite seu email",
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Digite sua senha",
                labelText: "Senha",
              ),
            ),
            const SizedBox(height: 160),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _store.navigateToHome(context);
                },
                child: const Text("Entrar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
