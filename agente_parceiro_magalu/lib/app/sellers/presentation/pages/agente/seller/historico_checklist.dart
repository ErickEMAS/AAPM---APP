import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
        title: "Histórico de visita",
      ),
    );
  }
}
