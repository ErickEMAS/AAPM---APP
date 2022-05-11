import 'package:agente_parceiro_magalu/app/calendar/presentation/stores/agente/calendar_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/seller_list_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/seller_card_widget.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/api/calendar_api.dart';
import 'package:agente_parceiro_magalu/core/api/google_api.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  final SellerStore _sellerStore = serviceLocator<SellerStore>();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // GoogleApi.googleUser == null
      //     ? GoogleApi.signIn().whenComplete(() {
      //         LoadingOverlay.of(context).during(_store.onInit());
      //       })
      //     :
      LoadingOverlay.of(context).during(_store.onInit());
    });

    // fetchData();

    super.initState();
  }

  fetchData() async {
    await CalendarClient().getGoogleEventsData();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Roteiro de visitas",
                  style: AppTextStyles.bold(),
                ),
                _adicionarButton(context),
              ],
            ),
            GoogleApi.googleUser == null
                ? Column(
                    children: [
                      Text(
                          "Você deve logar a sua conta do google pra acessar essa tela"),
                      ElevatedButton(
                        onPressed: () {
                          GoogleApi.signIn().whenComplete(() {
                            setState(() {});
                            fetchData();
                          });
                        },
                        child: Text("Entrar google"),
                      )
                    ],
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: CalendarClient().getGoogleEventsData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        snapshot.data == null ? fetchData() : null;
                        return Stack(
                          children: [
                            SfCalendar(
                              view: CalendarView.schedule,
                              todayHighlightColor: AppColors.primary,
                              cellBorderColor: AppColors.primary,
                              allowViewNavigation: true,
                              dataSource: GoogleCalendarDatasource(
                                  events: snapshot.data),
                              scheduleViewSettings: ScheduleViewSettings(
                                appointmentItemHeight: 70,
                                dayHeaderSettings: DayHeaderSettings(
                                  dayFormat: 'EEEE',
                                  width: 70,
                                  dayTextStyle: AppTextStyles.regular(
                                      size: 12, color: AppColors.vermelho),
                                  dateTextStyle: AppTextStyles.regular(
                                    size: 12,
                                    color: AppColors.vermelho,
                                  ),
                                ),
                                hideEmptyScheduleWeek: true,
                              ),
                            ),
                            snapshot.data != null
                                ? Container()
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )
                          ],
                        );
                      },
                    ),
                  ),
          ]),
        ),
      ),
    );
  }

  _adicionarButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _store.setSearch("");
        bool ret =
            await LoadingOverlay.of(context).during(_store.getAllSellers());

        if (ret) {
          _displayDialog(context);
        }

        // CalendarClient().insert(
        //   "Visitar Alfredo",
        //   DateTime.now().add(Duration(days: 0, hours: 3)),
        //   DateTime.now().add(Duration(hours: 5)),
        // );
        // await LoadingOverlay.of(context).during(fetchData()).whenComplete(() {
        //   setState(() {});
        // });
      },
      child: Text("Adicionar"),
    );
  }

  _displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppDimens.margin),
            child: Column(
              children: [
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Lista de Sellers"),
                    CloseButton(
                      color: AppColors.primary,
                      onPressed: () {
                        Navigator.pop(context);
                        _store.setSearch("");
                      },
                    ),
                  ],
                ),
                SearchFilterWidget(
                  onChanged: (value) {
                    _store.setSearch(value);
                    setState(() {});
                    _store.getAllSellers();
                    setState(() {});
                  },
                ),
                Observer(builder: (_) {
                  return Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _store.sellerList.length,
                        itemBuilder: (context, index) {
                          print(_store.sellerList.length);
                          return SellerCardWidget(
                            sellerModel: _store.sellerList[index],
                            onAddButtonPressed: () {},
                          );
                        },
                      ),
                    ),
                  );
                }),
                // SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}
