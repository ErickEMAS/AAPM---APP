import 'package:agente_parceiro_magalu/app/account/presentation/stores/carteiras_without_owner_store.dart';
import 'package:agente_parceiro_magalu/app/agent/data/models/user_agent_model.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/pages/widget/agent_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../shared/themes/app_text_styles.dart';
import '../../../../../shared/widgets/app_dialog_widget.dart';

class AgentListForCarteiraView extends StatefulWidget {
  const AgentListForCarteiraView({Key? key}) : super(key: key);

  @override
  State<AgentListForCarteiraView> createState() =>
      _AgentListForCarteiraViewState();
}

class _AgentListForCarteiraViewState extends State<AgentListForCarteiraView> {
  final CarteirasWithOwnerStore _store =
      serviceLocator<CarteirasWithOwnerStore>();

  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.getUsers());
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoadingOverlay.of(context).during(_store.fetchNextAgentPage());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

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
          body: Content(),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
    ;
  }

  Column Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Observer(builder: (_) {
            return Column(
              children: [
                Observer(builder: (_) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          labelText: "Pesquisa",
                          hintText: "Pesquisar Agente",
                        ),
                        onChanged: (value) {
                          _store.setSearch(value);
                          _store.getUsers();
                        },
                      ),
                      SizedBox(height: AppDimens.space),
                    ],
                  );
                })
              ],
            );
          }),
        ),
        Observer(builder: (_) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _store.userAgenteModelList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    _store.userAgentselected =
                        _store.userAgenteModelList[index],
                    _modalUser(),
                  },
                  child: Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _row(
                                  atributo: "Nome",
                                  value:
                                      "${_store.userAgenteModelList[index].fullName}",
                                ),
                                _row(
                                  atributo: "Email",
                                  value:
                                      "${_store.userAgenteModelList[index].email}",
                                ),
                                _row(
                                  atributo: "CPF",
                                  value: maskCPF(
                                      cpf: _store
                                          .userAgenteModelList[index].cpf),
                                ),
                                _row(
                                  atributo: "Usuário ativo",
                                  value: _store.userAgenteModelList[index]
                                          .accountNonLocked!
                                      ? "Sim"
                                      : "Não",
                                ),
                                _row(
                                  atributo: "Primeiro acesso realizado",
                                  value:
                                      _store.userAgenteModelList[index].enabled!
                                          ? "Sim"
                                          : "Não",
                                ),
                                _row(
                                  atributo: "Função",
                                  value: _store.userAgenteModelList[index]
                                              .roles[0] ==
                                          "ROLE_ADMIN"
                                      ? "Administrador"
                                      : "Agente",
                                ),
                                _row(
                                  atributo: "Sellers",
                                  value:
                                      "${_store.userAgenteModelList[index].totalSeller}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
        SizedBox(height: AppDimens.margin * 3)
      ],
    );
  }

  Row _row({required String value, required String atributo}) {
    return Row(
      children: [
        Text(
          "$atributo: ",
          style: AppTextStyles.bold(size: 12, color: AppColors.primary),
        ),
        Text(
          value,
          style: AppTextStyles.bold(size: 12, color: AppColors.black),
        ),
      ],
    );
  }

  _modalUser() {
    return appDialog(
      context: context,
      title: Text(
        "Tranferir Carteira",
        style: AppTextStyles.bold(
          size: 18,
          color: AppColors.primary,
        ),
      ),
      content: Observer(builder: (_) {
        return Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Carteira",
                style: AppTextStyles.bold(
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              _row(
                atributo: "Id",
                value: "${_store.carteiraSelected.id}",
              ),
              _row(
                atributo: "Total de sellers",
                value: "${_store.carteiraSelected.sellers!.length}",
              ),
              const Divider(),
              Text(
                "Agente",
                style: AppTextStyles.bold(
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              _row(
                atributo: "Nome",
                value: "${_store.userAgentselected.fullName}",
              ),
              _row(
                atributo: "Email",
                value: "${_store.userAgentselected.email}",
              ),
              _row(
                atributo: "CPF",
                value: maskCPF(cpf: _store.userAgentselected.cpf),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        _store.transferCarteira(),
                        _store.navigateback(context),
                        _store.navigateback(context),
                      },
                      child: Text(
                        "Tranferir",
                        style: AppTextStyles.bold(
                          size: 15,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
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
