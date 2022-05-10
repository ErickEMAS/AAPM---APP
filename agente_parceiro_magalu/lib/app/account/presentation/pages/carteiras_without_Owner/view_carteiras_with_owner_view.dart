import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/locators/service_locators.dart';
import '../../stores/carteiras_without_owner_store.dart';

class ViewCarteirasWithOwnerView extends StatefulWidget {
  const ViewCarteirasWithOwnerView({Key? key})
      : super(key: key);

  @override
  State<ViewCarteirasWithOwnerView> createState() => _ViewCarteirasWithOwnerViewState();
}

class _ViewCarteirasWithOwnerViewState extends State<ViewCarteirasWithOwnerView> {
  final CarteirasWithOwnerStore _store = serviceLocator<CarteirasWithOwnerStore>();

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Form(
          key: _store.formKey,
          child: Column(children: []),
        ),
      ),
    );
  }

}
