import 'dart:convert';

import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'dart:io';

import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/add_seller_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/seller_list_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/api/google_api.dart';
import 'package:agente_parceiro_magalu/core/api/sheets/seller_sheets_api.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
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

  PageController pageController = PageController();

  int currentPage = 0;

  _nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    _store.sellerList.clear();
    setState(() {
      currentPage = 1;
    });
    _store.reset();
  }

  _previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    LoadingOverlay.of(context).during(_store.onSellerInit());
    setState(() {
      currentPage = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onSellerInit());
    });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.setRole());
    });
  }

  @override
  void dispose() {
    _store.sellerList.clear();
    _store.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        appBar: AppBarGradient(
          leading: currentPage == 1
              ? BackButton(
                  onPressed: () => _previousPage(),
                )
              : null,
          title: "Meus Sellers",
          // actions: [
          //   _exportAllSellersFromList(),
          // ],
        ),
        floatingActionButton: currentPage == 0
            ? SpeedDial(
                animatedIcon: AnimatedIcons.menu_close,
                children: !_store.admin
                    ? [
                        SpeedDialChild(
                          child: Icon(Icons.add),
                          label: "Adicionar novo Seller",
                          onTap: () async {
                            _nextPage();
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
                            String? ret =
                                await _store.readSheets(context: context);

                            if (ret != null) _returnMsg(string: ret);
                          },
                        ),
                      ]
                    : [
                        SpeedDialChild(
                          child: Icon(Icons.file_download),
                          label: "Exportar Sellers",
                          onTap: () async {
                            await _store.forceGetSellers();
                            creatSheet();
                          },
                        ),
                      ],
              )
            : null,
        body: PageView.builder(
          clipBehavior: Clip.none,
          itemCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemBuilder: (context, index) {
            return index == 0
                ? const SellerListView()
                : AddSellerView(
                    previousPage: _previousPage,
                  );
          },
        ),
        bottomNavigationBar: AppBottomBar(),
      ),
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

  _exportAllSellersFromList() {
    return ElevatedButton(
        onPressed: () async {
          // List<SellerModel>? seller = await _store.getAllSellers();

          // await SellerSheetsApi.init();

          // if (seller != null) {
          //   final sellerDecode = SheetsFieldModel.fromJsonSellerModelList(
          //       jsonDecode(jsonEncode(seller)));

          //   final jsonList =
          //       sellerDecode.map((seller) => seller.toJson()).toList();

          //   SellerSheetsApi.insertList(jsonList);
          // }

          GoogleApi.signIn();
        },
        style: ElevatedButton.styleFrom(
          primary: AppColors.white,
        ),
        child: Text(
          "exportar",
          style: AppTextStyles.bold(
            color: AppColors.primary,
          ),
        ));
  }
}
