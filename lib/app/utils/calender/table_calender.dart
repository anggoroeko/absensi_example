// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:absensi_example/app/modules/aktivitas/controllers/aktivitas_controller.dart';
import 'package:absensi_example/app/modules/lembur/controllers/lembur_controller.dart';
import 'package:absensi_example/app/modules/permit/controllers/permit_controller.dart';
import 'package:absensi_example/app/utils/calender/calender_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatelessWidget {
  String name;
  CalenderPage({required this.name});
  final calenderC = Get.put(CalenderController());
  final aktivitas = Get.put(AktivitasController());
  final permit = Get.put(PermitController());
  final lembur = Get.put(LemburController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10)),
          child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              locale: 'en_US',
              calendarFormat: CalendarFormat.month,
              onDaySelected: (selectedDay, focusedDay) async {
                calenderC.selectedDay = selectedDay;
                calenderC.focusedDay = focusedDay;
                calenderC.tanggal.value = DateFormat.d().format(selectedDay);
                calenderC.tanggalview.value =
                    DateFormat.yMMMMd().format(selectedDay);
                var tanggal = DateFormat("yyyy-MM-dd").format(selectedDay);

                if (name == 'Aktivitas') {
                  await aktivitas.listAktivitas(tanggal);
                }
                if (name == 'Permit') {
                  await permit.listPermit(tanggal);
                }

                if (name == 'Lembur') {
                  await lembur.listLembur(tanggal);
                }
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, _) {
                  return Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ));
                },
                todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.sunday ||
                      day.weekday == DateTime.saturday) {
                    final text = DateFormat.E().format(day);
                    return Center(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                },
              ),
              headerVisible: true),
        ),
      ),
    );
  }
}
