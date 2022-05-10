import 'package:agente_parceiro_magalu/app/account/presentation/pages/huntings/widget/hunting_card_widget.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../stores/hunting_store.dart';

class HuntingListView extends StatefulWidget {
  const HuntingListView({Key? key}) : super(key: key);

  @override
  State<HuntingListView> createState() => _HuntingListViewState();
}

class _HuntingListViewState extends State<HuntingListView> {
final HuntingStore _store = serviceLocator<HuntingStore>();

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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(builder: (_) {
          return Flexible(
            child: ListView.builder(
              clipBehavior: Clip.none,
              // shrinkWrap: true,
              itemCount: _store.huntingModelList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return HuntingCardWidget(huntingModel: _store.huntingModelList[index]);
              },
            ),
          );
        }),
        ],
      );
  }
}
