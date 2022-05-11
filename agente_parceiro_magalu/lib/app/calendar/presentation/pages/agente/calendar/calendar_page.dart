import 'package:agente_parceiro_magalu/app/calendar/presentation/stores/agente/calendar_store.dart';
import 'package:agente_parceiro_magalu/core/api/calendar_api.dart';
import 'package:agente_parceiro_magalu/core/api/google_api.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/scheduler.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarStore _store = serviceLocator<CalendarStore>();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onInit());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "Agenda",
        ),
        body: Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Column(children: [
            Text(
              "Roteiro de visitas",
              style: AppTextStyles.bold(),
            ),
            // FutureBuilder(
            //   future: CalendarClient().getGoogleEventsData(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print("snap shot data${snapshot.data}");
            // return
            Stack(
              children: [
                SfCalendar(
                  view: CalendarView.month,
                  dataSource: GoogleCalendarDatasource(
                    events: _store.appointments,
                  ),
                  monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator,
                  ),
                ),
                _store.appointments != null
                    ? Container()
                    : Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
            //   },
            // ),
            ElevatedButton(
              onPressed: () {
                GoogleApi.googleUser != null
                    ? CalendarClient().insert(
                        "Lua é incrivel",
                        DateTime.now().add(Duration(days: 1)),
                        DateTime.now().add(Duration(days: 2)),
                      )
                    : GoogleApi.signIn().whenComplete(
                        () => CalendarClient().insert(
                          "Lua é incrivel",
                          DateTime.now().add(Duration(days: 1)),
                          DateTime.now().add(Duration(days: 2)),
                        ),
                      );
              },
              child: Text("Adicionar"),
            )
          ]),
        ),
      ),
    );
  }
}
