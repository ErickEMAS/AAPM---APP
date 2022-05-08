import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';

// class GoogleAuthClient extends http.BaseClient {
//   final Map<String, String> _headers;

//   final http.Client _client = new http.Client();

//   GoogleAuthClient(this._headers);

//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     return _client.send(request..headers.addAll(_headers));
//   }
// }

class GoogleApi {
  static GoogleSignInAccount? googleUser;

  static Future<GoogleSignInAccount?> signIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "819633463633-13laabfblvvlo3490k3bgol3qinghke6.apps.googleusercontent.com",
      scopes: <String>[
        SheetsApi.spreadsheetsScope,
      ],
    );

    try {
      googleUser = await _googleSignIn.signIn();
      print(googleUser);
      return googleUser;
    } catch (error) {
      print(error);
    }
  }

  // myGoogleSheet() async {
  //     var authenticateClient = await signInWithGoogle();
  //     var sheetID = await createSpreadSheet(authenticateClient);
  //     writeToSheet(authenticateClient, sheetID);
  //   }

  //   Future signInWithGoogle() async {
  //     final authHeaders = await googleUser!.authHeaders;
  //     final authenticateClient = GoogleAuthClient(authHeaders);
  //     return authenticateClient;
  //   }

  // static Future createSpreadSheet() async {
  //   final driveApi = DriveApi();
  //   var driveFile = File();
  //   driveFile.name = "hello_spreadsheet";
  //   driveFile.mimeType = 'application/vnd.google-apps.spreadsheet';
  //   final result = await driveApi.files.create(driveFile);
  //   return result.id;
  // }

  // writeToSheet(GoogleAuthClient authenticateClient, String sheetID) {
  //   final sheetsApi = sheets.SheetsApi(authenticateClient);
  //   sheets.ValueRange vr = new sheets.ValueRange.fromJson({
  //     "values": [
  //       ["2021/04/05", "via API", "5", "3", "3", "3", "3", "3", "3", "3"]
  //     ]
  //   });
  //   sheetsApi.spreadsheets.values.append(vr, sheetID, 'A:J', valueInputOption: 'USER_ENTERED').then((sheets.AppendValuesResponse r) {
  //     print('append completed');
  //   });
  // }

  // class GoogleAuthClient extends http.BaseClient {
  //   final Map _headers;
  //   final http.Client _client = new http.Client();
  //   GoogleAuthClient(this._headers);
  //   Future send(http.BaseRequest request) {
  //     return _client.send(request..headers.addAll(_headers));
  //   }
  // }
}

// class SheetsApi {
//   static drive() async {
//     final authHeaders = await GoogleApi.googleUser!.authHeaders;
//     final authenticateClient = GoogleAuthClient(authHeaders);
//     final driveApi = drive.DriveApi(authenticateClient);
//   }
// }
