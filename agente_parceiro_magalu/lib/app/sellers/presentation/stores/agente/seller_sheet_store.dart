import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
import 'package:agente_parceiro_magalu/core/api/sheets/seller_sheets_api.dart';
import 'package:gsheets/gsheets.dart';
import 'package:mobx/mobx.dart';
part 'seller_sheet_store.g.dart';

class SellerSheetStore = _SellerSheetStoreBase with _$SellerSheetStore;

abstract class _SellerSheetStoreBase with Store {
  static Worksheet? _sellerSheet;

  Future init() async {
    try {
      final spreadsheet = await SellerSheetsApi.gsheets
          .spreadsheet(SellerSheetsApi.spreadSheetId);
      _sellerSheet = await _getWorkSheet(spreadsheet, title: 'Seller');

      final firstRow = SellerField.getFields();
      _sellerSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('init error $e');
    }
  }

  Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  Future insert(Map<String, dynamic> rowList) async {
    if (_sellerSheet == null) return;
    _sellerSheet!.values.map.appendRow(rowList);
  }

  Future<SheetsFieldModel?> getSellerByCNPJ(String cnpj) async {
    if (_sellerSheet == null) return null;

    final json = await _sellerSheet!.values.map.rowByKey(cnpj, fromColumn: 1);

    return json == null ? null : SheetsFieldModel.fromJsonSheet(json);
  }
}
