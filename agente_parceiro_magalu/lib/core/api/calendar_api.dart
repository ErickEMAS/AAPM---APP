import 'dart:developer';
import 'package:agente_parceiro_magalu/core/api/google_api.dart';
import 'package:agente_parceiro_magalu/core/api/google_auth_client.dart';
import 'package:googleapis/calendar/v3.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:googleapis/calendar/v3.dart' as calendar;

class CalendarClient {
  // static final _scopes = [CalendarApi.calendarScope];

  insert(title, startTime, endTime) async {
    String calendarId = "";
    String eventID = "";

    final signIn.GoogleSignInAccount? account = GoogleApi.googleUser;

    final authHeaders = await account!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);

    var calendarApi = CalendarApi(authenticateClient);
    bool agendaExiste = false;

    // calendarApi.calendarList.list().then((value) {
    //   for (var item in value.items!) {
    //     if (item.summary!.toLowerCase() == "app_agente") {
    //       calendarId = item.id!;
    //       agendaExiste = true;
    //     }
    //   }

    //   if (agendaExiste != true) {
    //     final request = Calendar(
    //       summary: "app_agente",
    //       description: "app agente magalu",
    //     );

    //     calendarApi.calendars.insert(request);
    //   }
    // });

    await addFolder();

    calendarApi.calendarList.list().then((value) {
      for (var item in value.items!) {
        if (item.summary!.toLowerCase() == "app_agente") {
          calendarId = item.id!;
        }
      }

      Event event = Event();

      event.summary = title;

      EventDateTime start = EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "UTC-3";
      event.start = start;

      EventDateTime end = EventDateTime();
      end.timeZone = "UTC-3";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendarApi.events.insert(event, calendarId).then((value) async {
          if (value.status == "confirmed") {
            print('event adicionado --> ${value.id}');
            eventID = value.id!;
          } else {
            print("erro ao adicionar evento ");
          }
        });
      } catch (e) {
        print(e);
      }
    });
  }

  Future addFolder() async {
    final signIn.GoogleSignInAccount? account = GoogleApi.googleUser;

    final authHeaders = await account!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);

    var calendarApi = CalendarApi(authenticateClient);
    bool agendaExiste = false;

    await calendarApi.calendarList.list().then((value) {
      for (var item in value.items!) {
        if (item.summary!.toLowerCase() == "app_agente") {
          // calendarId = item.id!;
          agendaExiste = true;
        }
      }

      print("fora do for item$agendaExiste");
    });

    if (agendaExiste != true) {
      final request = Calendar(
        summary: "app_agente",
        description: "app agente magalu",
      );
      print("if agenda existe$agendaExiste");

      calendarApi.calendars.insert(request);
    }
  }

  delete(eventID) async {
    String calendarId = "";

    final signIn.GoogleSignInAccount? account = GoogleApi.googleUser;

    final authHeaders = await account!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);

    var calendarApi = CalendarApi(authenticateClient);
    calendarApi.calendarList.list().then((value) {
      for (var item in value.items!) {
        if (item.summary!.toLowerCase() == "app_agente") {
          calendarId = item.id!;
        }
      }

      try {
        print("eventID ---> $eventID");
        calendarApi.events.delete(calendarId, eventID).then((value) async {
          print("foi");
        });
      } catch (e) {
        print("erro ao sincronizar com o Google");
        print('error deletando evento $e');
      }
    });
  }

  Future<List<Event>?> getGoogleEventsData() async {
    final account = GoogleApi.googleUser;

    if (account == null) return [];

    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);

    var calendarApi = CalendarApi(authenticateClient);
    String calendarId = "";
    bool agendaExiste = false;

    List<Event> appointments = <Event>[];

    // await addFolder();

    await calendarApi.calendarList.list().then((value) async {
      for (var item in value.items!) {
        if (item.summary!.toLowerCase() == "app_agente") {
          calendarId = item.id!;
        }
      }

      final Events calEvents = await calendarApi.events.list(
        calendarId,
      );
      if (calEvents.items != null) {
        for (int i = 0; i < calEvents.items!.length; i++) {
          final Event event = calEvents.items![i];
          if (event.start == null) {
            continue;
          }
          appointments.add(event);
        }
      }
    });

    return appointments;
  }

  void prompt(String url) async {
    var uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class GoogleCalendarDatasource extends CalendarDataSource {
  GoogleCalendarDatasource({List<Event>? events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final Event event = appointments![index];
    return event.start!.date ?? event.start!.dateTime!.toLocal();
  }

  @override
  bool isAllDay(int index) {
    print(appointments);

    return appointments![index].start!.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final Event event = appointments![index];

    if (event.endTimeUnspecified != null) {
      return (event.start!.date ?? event.start!.dateTime!.toLocal());
    } else {
      return (event.end!.date != null
          ? event.end!.date!.add(const Duration(days: -1))
          : event.end!.dateTime!.toLocal());
    }
  }

  @override
  String? getLocation(int index) {
    return appointments![index].location;
  }

  @override
  String? getNotes(int index) {
    return appointments![index].description;
  }

  @override
  String getSubject(int index) {
    final Event event = appointments![index];
    return event.summary == null ? 'No Title' : event.summary!;
  }
}
