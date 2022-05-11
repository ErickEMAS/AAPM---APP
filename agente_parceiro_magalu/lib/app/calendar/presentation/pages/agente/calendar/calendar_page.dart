import 'package:agente_parceiro_magalu/app/calendar/presentation/stores/agente/calendar_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/seller_card_widget.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/api/calendar_api.dart';
import 'package:agente_parceiro_magalu/core/api/google_api.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
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

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController1 = TextEditingController();
  TextEditingController _timeController2 = TextEditingController();
  final CalendarController _controller = CalendarController();

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
                            LoadingOverlay.of(context)
                                .during(fetchData())
                                .whenComplete(() {
                              setState(() {});
                            });
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
                              allowedViews: const [
                                CalendarView.schedule,
                                CalendarView.day,
                                CalendarView.workWeek,
                              ],
                              onTap: (calendarTapDetails) {
                                if (calendarTapDetails.targetElement ==
                                        CalendarElement.agenda ||
                                    calendarTapDetails.targetElement ==
                                        CalendarElement.appointment) {
                                  final calendar.Event appointment =
                                      calendarTapDetails.appointments![0];

                                  print(appointment);
                                  appDialog(
                                    context: context,
                                    title: Text("Excluir visita?"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            LoadingOverlay.of(context)
                                                .during(
                                              CalendarClient().delete(
                                                appointment.id,
                                              ),
                                            )
                                                .whenComplete(() {
                                              LoadingOverlay.of(context)
                                                  .during(fetchData())
                                                  .whenComplete(() {
                                                setState(() {});
                                              });
                                              setState(() {});
                                              Navigator.pop(context);
                                              SnackBarHelper.snackBar(
                                                context,
                                                message: "Visita exluida",
                                              );
                                            });
                                          },
                                          child: Text("Exluir!"),
                                        )
                                      ],
                                    ),
                                  );
                                  // _selectedAppointment = appointment;
                                }
                              },
                              controller: _controller,
                              todayHighlightColor: AppColors.primary,
                              // cellBorderColor: AppColors.primary,
                              selectionDecoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red, width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                shape: BoxShape.rectangle,
                              ),

                              dataSource: GoogleCalendarDatasource(
                                  events: snapshot.data),
                              scheduleViewSettings: ScheduleViewSettings(
                                appointmentItemHeight: 70,
                                dayHeaderSettings: DayHeaderSettings(
                                  dayFormat: 'EEE',
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
    return GoogleApi.googleUser != null
        ? ElevatedButton(
            onPressed: () async {
              _store.setSearch("");
              bool ret = await LoadingOverlay.of(context)
                  .during(_store.getAllSellers());

              if (ret) {
                _displayDialog(context);
              }
            },
            child: Text("Adicionar"))
        : SizedBox();
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
                  dropdown: false,
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
                            onAddButtonPressed: () {
                              _addSellerToCalendar(_store.sellerList[index]);
                            },
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

  _addSellerToCalendar(SellerModel sellerModel) {
    return appDialog(
      context: context,
      title: Text(
        "Adicionar Seller na Agenda",
        style: AppTextStyles.bold(),
      ),
      content: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _datePicker(),
            _timePicker(
              controller: _timeController1,
              label: "Hora inicial",
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  final text = selectedTime.toString().substring(10, 15);
                  _store.horaInicio = selectedTime;
                  setState(() {
                    _timeController1.text = text;
                  });
                }
              },
            ),
            SizedBox(height: AppDimens.margin),
            _timePicker(
              controller: _timeController2,
              label: "Hora final",
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  final text = selectedTime.toString().substring(10, 15);
                  _store.horaFim = selectedTime;
                  setState(() {
                    _timeController2.text = text;
                  });
                }
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  _dateController.text = '';
                  _timeController1.text = '';
                  _timeController2.text = '';
                  Navigator.pop(context);
                  Navigator.pop(context);
                  CalendarClient().insert(
                    "Visitar ${sellerModel.nome}",
                    _store.date!.add(
                      Duration(
                          hours: _store.horaInicio!.hour,
                          minutes: _store.horaInicio!.minute),
                    ),
                    _store.date!.add(
                      Duration(
                          hours: _store.horaFim!.hour,
                          minutes: _store.horaFim!.minute),
                    ),
                  );
                  print(
                    _store.date!.add(
                      Duration(
                        hours: _store.horaInicio!.hour,
                        minutes: _store.horaInicio!.minute,
                      ),
                    ),
                  );

                  await LoadingOverlay.of(context)
                      .during(fetchData())
                      .whenComplete(() {
                    setState(() {});
                  });
                  SnackBarHelper.snackBar(
                    context,
                    message: "Visita adicionada",
                  );
                },
                child: Text("Adicionar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _datePicker() {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "Data",
        hintText: "Selecione a data",
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (selectedDate != null) {
          final date = _store.convertDateTime(now: selectedDate);
          _store.date = selectedDate;
          setState(() {
            _dateController.text = date;
          });
        }
      },
    );
  }

  _timePicker({
    required TextEditingController controller,
    required String label,
    void Function()? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Selecione a hora",
      ),
      // _store.date = selectedDate;

      onTap: onTap,
    );
  }
}
