import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/widget/questions_checklist_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/agent/data/models/user_agent_model.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/pages/widget/agent_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/agent/presentation/stores/user_agent_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/themes/app_text_styles.dart';
import '../../../../shared/widgets/app_dialog_widget.dart';

class AgentListView extends StatefulWidget {
  const AgentListView({Key? key}) : super(key: key);

  @override
  State<AgentListView> createState() => _AgentListViewState();
}

class _AgentListViewState extends State<AgentListView> {
  final UserAgentStore _store = serviceLocator<UserAgentStore>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoadingOverlay.of(context).during(_store.fetchNextPage());
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Observer(builder: (_) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _store.setSearchClicked(!_store.searchClicked);
                      },
                      icon: Icon(_store.searchClicked
                          ? Icons.close
                          : Icons.filter_list),
                    )
                  ],
                ),
                _store.searchClicked
                    ? const AgenteSearchFilterWidget()
                    : const SizedBox(),
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
                  onTap: () {
                    _store.userAgentselected = _store.userAgenteModelList[index];
                    _store.navigateToUserOverview(context);
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
                                _rowUser(
                                  atributo: "Nome",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value:
                                      "${_store.userAgenteModelList[index].fullName}",
                                ),
                                _rowUser(
                                  atributo: "Email",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value:
                                      "${_store.userAgenteModelList[index].email}",
                                ),
                                _rowUser(
                                  atributo: "CPF",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value: maskCPF(
                                      cpf: _store
                                          .userAgenteModelList[index].cpf),
                                ),
                                _rowUser(
                                  atributo: "Usuário ativo",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value: _store.userAgenteModelList[index]
                                          .active!
                                      ? "Sim"
                                      : "Não",
                                ),
                                _rowUser(
                                  atributo: "Primeiro acesso realizado",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value:
                                      _store.userAgenteModelList[index].enabled!
                                          ? "Sim"
                                          : "Não",
                                ),
                                _rowUser(
                                  atributo: "Função",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value: _store.userAgenteModelList[index]
                                              .roles[0] ==
                                          "ROLE_ADMIN"
                                      ? "Administrador"
                                      : "Agente",
                                ),
                                _rowUser(
                                  atributo: "Sellers",
                                  active: _store.userAgenteModelList[index]
                                      .active!,
                                  value:
                                      "${_store.userAgenteModelList[index].totalSeller}",
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 16),
                          child: IconButton(
                            onPressed: () => {
                              _store.userAgentselected =
                                  _store.userAgenteModelList[index],
                              _modalUser(
                                user: _store.userAgentselected,
                                index: index,
                              ),
                            },
                            icon: Icon(
                              _store.userAgenteModelList[index]
                                      .active!
                                  ? Icons.person_remove
                                  : Icons.person_add,
                              size: 32,
                              color: _store.userAgenteModelList[index]
                                      .active!
                                  ? AppColors.black
                                  : AppColors.grey,
                            ),
                          ),
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

  _modalUser({required UserAgentModel user, required int index}) {
    return appDialog(
      context: context,
      title: Text(
        user.active! ? "Desativar usuário" : "Reativar Usuário",
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
              _rowUser(
                atributo: "Nome",
                active: true,
                value: "${user.fullName}",
              ),
              _rowUser(
                atributo: "Email",
                active: true,
                value: "${user.email}",
              ),
              _rowUser(
                atributo: "CPF",
                active: true,
                value: maskCPF(cpf: user.cpf),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                      ),
                      onPressed: () => {
                        user.active!
                            ? _store.desactiveUser(index: index)
                            : _store.reactiveUser(index: index),
                        _store.navigateback(context),
                      },
                      child: Text(
                        user.active! ? "Desativar" : "Reativar",
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
