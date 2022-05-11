// import 'dart:convert';

// import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
// import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
// import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
// import 'package:gsheets/gsheets.dart';

// class SellerSheetsApi {
//   static const _credentials = r'''
// {
//   "type": "service_account",
//   "project_id": "flutter-magalu",
//   "private_key_id": "17797becfb3459c79776128eb9ea64e4856003c1",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDwrFVTpFfzt45X\nhOFU6f6GuBMf5/PVT3knInzXm/WDDgQ0gUfU9xhZVl4qGZfdaoLj4MorwVJxldsQ\nh5t8E9ZpUPM9oiHxEz/+HUExlW5BBTD+4TY50raQf8Hlm0JW+0xXGfIxX/NLlJmM\nkqZUycGaamsSyrUt/XVBasr8NZuwGIoAKVn6jIrVFryfHVhuVYDi0/rcSPxV2WMt\njwsdYPTDvIoBrqKHvTfIRxnEhMCPq+lOr3lyNpI0Z1N7AfVAyeKyB3CZCRSl55Ir\nWpaANetes17JNgAh7psg/KRc/XxqRx8onlubdhB4cHqGAKkT7UoHeWTkTtNtceCb\nGq9pfHw3AgMBAAECggEAdoGE6lCL9je14SZPBc7KQ2+0CwvdpnUhhMGYk1n6A/QM\n4gWeZyDcXnEGoNhFTQM7PBXdtrnUbJWLbpI3X1stQmJXw0toRxphcjDZfx7DUUTL\nIVWnq8Uzm+cshHB0s/u9VU4zUVibpeWfzfYP7MQDjpND8dbaa7DX4cRB+voylPwr\nt+vPFU0k+qeES4qmPXS7jZGqR/MAijQE2n5cSJCwRNhzqDjXKjmhgpH4V3Pi5pNL\ndsaz1vloj3JOKRaWqAduATu/7whlPhEdx4FoJpqu3xBxF+z4pnrLOaOX22hPg8HH\nF68omBs0EVqn44QoGUpLY3RelFS5oQiyi+zoAWZ2kQKBgQD/8MLXz/xzpUmGK4zG\nTBFQTI9yCHTK3a36Ofw9N9dULKi4wZfD80i9WzFiyWwmScuYAjk7mVhlynkT4cSc\nyPOtCyop54+JNaLfk2hRhlGrG+F89omXACuZryP/Yswb4sclNVDefxIcbUATnbZ8\nxA+cr/PL9Ah4wDvEgiwiGY0GgwKBgQDwuqnF27TVlPXKbSnGolBuMVl2jYAA8PQ4\nHIe5O0lMpWooKN+Mk0ZLRTelKvJQmlSBQuzN5fage84PJfNM5ZUD8B7HM+RKMX/E\nuT1uFc8zaVUYALt6mtcwkE2Aos0ISAZvYUDDCeyC/jyPusT64KQoMgAZevtnJjhB\nSFwr8HslPQKBgQCaUTV54Frr854IOtvveE/8JZ1b+UNKSi0rMakn1DKN+ztj4r46\nFMcn/QMi+CWwVFBgf/64M7Z78X/dgAQHMJbUIGY0y/zcky14Nq3wcdduHypvKUs+\nc4jWaiZ/RregnLTMd4AiF2X5I9o9uZsdUS3EoMaTk7lD7UxcKMypZtSENwKBgHm/\nXgeUM2Pln12OUheElbr1OHLN45QWSN1sCHR0+IBMFGFVMqJNBbshuZ/OFZkQRHbP\nWyZTDKVjl/ZvUhps7i18roQ+yVGAsUbUDK51V0KAHioyjJ7YWsbT5G6PZ7StgJuq\nCu/ZQAWMASML6X2cSUmO6B/649TqLn9N0lfimtVdAoGAayoANULvDKhoQaGP1xKD\nAuZsZ9tyZM0xdgVGtNaZqeZOC9KTqoxVos606mjCnhc2K2t6xNOJPKZnjxjLgaI1\n9rBqe9uphclwUzWYKyG6ZzLmb5ZV3auwgkoMoLevVQgnW72c3punoxITcEQk3GvA\nAB6yJJIPy6iOoTg9rreUTYU=\n-----END PRIVATE KEY-----\n",
//   "client_email": "gsheets@flutter-magalu.iam.gserviceaccount.com",
//   "client_id": "114234049884630266215",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40flutter-magalu.iam.gserviceaccount.com"
// }
// ''';

//   //id da planilha no google sheets

//   static const spreadSheetId = '13LlWnOlR8o-SbQ7wvqeSyXatpVK4nECq7lTV5wf2dwI';

//   static final gsheets = GSheets(_credentials);

//   static Worksheet? _sellerSheet;

//   static Future init() async {
//     try {
//       String? sheetId =
//           await SecureStorageHelper.read(key: StorageKeys.idSheets);

//       if (sheetId == null) return;

//       final spreadsheet = await SellerSheetsApi.gsheets.spreadsheet(sheetId);
//       _sellerSheet = await _getWorkSheet(spreadsheet, title: 'Seller');

//       final firstRow = SellerField.getFields();
//       _sellerSheet!.values.insertRow(1, firstRow);
//     } catch (e) {
//       print('init error $e');
//     }
//   }

//   static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
//       {required String title}) async {
//     try {
//       return await spreadsheet.addWorksheet(title);
//     } catch (e) {
//       return spreadsheet.worksheetByTitle(title)!;
//     }
//   }

//   static Future insert(Map<String, dynamic> rowList) async {
//     if (_sellerSheet == null) return;
//     _sellerSheet!.values.map.appendRow(rowList);
//   }

//   static Future insertList(List<Map<String, dynamic>> rowList) async {
//     if (_sellerSheet == null) return;
//     _sellerSheet!.values.map.appendRows(rowList);
//   }

//   static Future<SheetsFieldModel?> getSellerByCNPJ(String cnpj) async {
//     if (_sellerSheet == null) return null;

//     final json = await _sellerSheet!.values.map.rowByKey(cnpj, fromColumn: 1);

//     return json == null ? null : SheetsFieldModel.fromJsonSheet(json);
//   }

//   static Future<List<SheetsFieldModel>?> getAllSeller() async {
//     if (_sellerSheet == null) return null;

//     final json = await _sellerSheet!.values.map.allRows(
//       fromRow: 2,
//     );

//     var teste =
//         SheetsFieldModel.fromJsonSheetList(jsonDecode(jsonEncode(json)));

//     return teste;
//   }
// }
