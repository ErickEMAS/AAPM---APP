import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/widget/questions_checklist_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/agent/data/models/user_agent_model.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/pages/widget/agent_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/stores/user_agent_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/themes/app_text_styles.dart';
import '../../../../shared/widgets/app_dialog_widget.dart';
import '../../../sellers/presentation/pages/agente/seller/page_view/widgets/seller_card_widget.dart';

class UserAgenteOverview extends StatefulWidget {
  const UserAgenteOverview({Key? key}) : super(key: key);

  @override
  State<UserAgenteOverview> createState() => _UserAgenteOverviewState();
}

class _UserAgenteOverviewState extends State<UserAgenteOverview> {
  final UserAgentStore _store = serviceLocator<UserAgentStore>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.getUserCarteira());
    });
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const AppBarGradient(
        title: "Usuário",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              return Column(
                      children: [
                        userDetail(),
                        listSellers(),
                      ],
                    );
            }),
            SizedBox(height: AppDimens.margin * 3)
          ],
        ),
      ),
    );
  }

  Container userDetail() {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowUser(
            atributo: "Nome",
            active: _store.userAgentselected.active!,
            value: "${_store.userAgentselected.fullName}",
          ),
          _rowUser(
            atributo: "Email",
            active: _store.userAgentselected.active!,
            value: "${_store.userAgentselected.email}",
          ),
          _rowUser(
            atributo: "CPF",
            active: _store.userAgentselected.active!,
            value: maskCPF(cpf: _store.userAgentselected.cpf),
          ),
          _rowUser(
            atributo: "Usuário ativo",
            active: _store.userAgentselected.active!,
            value: _store.userAgentselected.active!
                ? "Sim"
                : "Não",
          ),
          _rowUser(
            atributo: "Primeiro acesso realizado",
            active: _store.userAgentselected.active!,
            value: _store.userAgentselected.enabled! ? "Sim" : "Não",
          ),
          _rowUser(
            atributo: "Função",
            active: _store.userAgentselected.active!,
            value: _store.userAgentselected.roles[0] == "ROLE_ADMIN"
                ? "Administrador"
                : "Agente",
          ),
          SizedBox(height: 16),
          _rowUser(
            atributo: "Sellers",
            active: _store.userAgentselected.active!,
            value: "",
          ),
        ],
      ),
    );
  }

  Column listSellers() {
    return Column(
      children: _store.carteiraModel.sellers != null ? _store.carteiraModel.sellers!.map<SellerCardWidget>(
        (SellerModel seller) {
          return SellerCardWidget(sellerModel: seller);
        },
      ).toList() : [],
    );
  }

  Row _rowUser(
      {required String value, required String atributo, required bool active}) {
    return Row(
      children: [
        Text(
          "$atributo: ",
          style: AppTextStyles.bold(
              size: 14, color: active ? AppColors.primary : AppColors.grey),
        ),
        Text(
          value,
          style: AppTextStyles.bold(
              size: 14, color: active ? AppColors.black : AppColors.grey),
        ),
      ],
    );
  }

  String maskCPF({required String cpf}) {
    cpf.split("");
    return cpf[0] +
        cpf[1] +
        cpf[2] +
        "." +
        cpf[3] +
        cpf[4] +
        cpf[5] +
        "." +
        cpf[6] +
        cpf[7] +
        cpf[8] +
        "-" +
        cpf[9] +
        cpf[10];
  }
}
