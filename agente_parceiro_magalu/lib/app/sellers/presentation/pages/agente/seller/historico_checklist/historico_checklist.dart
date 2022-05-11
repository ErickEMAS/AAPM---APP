import 'package:agente_parceiro_magalu/app/sellers/data/models/checklist_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HistoricoChecklistPage extends StatefulWidget {
  final String sellerId;
  const HistoricoChecklistPage({
    Key? key,
    required this.sellerId,
  }) : super(key: key);

  @override
  State<HistoricoChecklistPage> createState() => _HistoricoChecklistPageState();
}

class _HistoricoChecklistPageState extends State<HistoricoChecklistPage> {
  final ChecklistStore _checklistStore = serviceLocator<ChecklistStore>();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(
        _checklistStore.getChecklistHistorico(widget.sellerId),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGradient(
        title: "Histórico de visitas",
      ),
      body: Column(
        children: [
          Observer(builder: (_) {
            return Flexible(
              child: ListView.builder(
                clipBehavior: Clip.none,
                itemCount: _checklistStore.checklistList.length,
                itemBuilder: (context, index) {
                  return _checklistCard(_checklistStore.checklistList[index]);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  _checklistCard(ChecklistModel checklistList) {
    return GestureDetector(
      onTap: () {
        _checklistStore.navigateToChecklistOverview(context, checklistList);
        print(checklistList.questions!.length);
        print("tap");
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimens.margin),
        clipBehavior: Clip.none,
        padding: EdgeInsets.all(AppDimens.space * 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.margin,
            vertical: AppDimens.space,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Visita feita: ${_checklistStore.formattDateTime(
                  checklistList.dataVisita ?? DateTime(2022),
                )}",
                style: AppTextStyles.bold(size: 14),
              ),
              SizedBox(height: AppDimens.space),
              Text(
                "Nome seller: ${checklistList.nomeAgente}",
                style: AppTextStyles.bold(size: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
