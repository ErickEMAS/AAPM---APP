import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
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
        CalendarApi.calendarScope,
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
}
