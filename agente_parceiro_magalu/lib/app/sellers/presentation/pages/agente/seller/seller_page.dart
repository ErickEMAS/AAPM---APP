import 'dart:io';

import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/add_seller_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/seller_list_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

import '../../../../../../shared/themes/app_colors.dart';
import '../../../../../../shared/themes/app_text_styles.dart';
import '../../../../../../shared/widgets/app_dialog_widget.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final SellerStore _store = serviceLocator<SellerStore>();

  @override
  void initState() {
    super.initState();
    _store.reset();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onSellerInit());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: AppBarGradient(
            leading: _store.currentPage == 1
                ? BackButton(
                    onPressed: () => _store.previousPage(),
                  )
                : null,
            title: "Carteira",
          ),
          floatingActionButton: _store.currentPage == 0
              ? SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.add),
                      label: "Adicionar novo Seller",
                      onTap: () async {
                        _store.nextPage();
                      },
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.file_download),
                      label: "Exportar Sellers",
                      onTap: () async {
                        await _store.forceGetSellers();
                        creatSheet();
                      },
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.file_upload),
                      label: "Importar Sellers",
                      onTap: () async {
                        String? ret = await _store.readSheets(context: context);

                        if (ret != null) _returnMsg(string: ret);
                      },
                    ),
                  ],
                )
              : null,
          body: PageView.builder(
            clipBehavior: Clip.none,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            controller: _store.pageController,
            itemBuilder: (context, index) {
              return index == 0 ? const SellerListView() : AddSellerView();
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }

  Future<void> creatSheet() async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    List<String> atributos = [
      "id",
      "cnpj",
      "helenaSellerCode",
      "nome",
      "telefone",
      "email",
      "cidade",
      "uf",
      "cep",
      "endereco",
      "numero",
      "complemento",
      "cadastro",
      "dataPedidoTeste"
    ];
    List<String> alf = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];

    for (int i = 0; i < atributos.length; i++) {
      String atributo = atributos[i];

      sheet.getRangeByName('${alf[i]}1').setText(atributo);
    }

    for (int s = 0; s < _store.sellerList.length; s++) {
      Map seller = _store.sellerList[s].toJson();

      for (int i = 0; i < atributos.length; i++) {
        String atributo = atributos[i];

        sheet.getRangeByName('${alf[i]}${s + 2}').setText(seller[atributo]);
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    for (int s = 0; s < _store.sellerList.length; s++) {
      Map seller = _store.sellerList[s].toJson();
    }

    OpenFile.open(fileName);
  }

  _returnMsg({required String string}) {
    return appDialog(
      context: context,
      title: Text(
        "Solicitação Finalizada",
        style: AppTextStyles.bold(
          size: 15,
          color: AppColors.primary,
        ),
      ),
      content: Observer(builder: (_) {
        return Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Text(string)],
          ),
        );
      }),
    );
  }
}
