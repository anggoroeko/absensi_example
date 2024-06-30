// ignore_for_file: unused_import, unnecessary_import

import 'dart:convert';
import 'dart:ui';

import 'package:absensi_example/app/data/models/aktivitas.dart';
import 'package:absensi_example/app/utils/calender/calender_controller.dart';
import 'package:absensi_example/app/utils/calender/table_calender.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/appbarpage.dart';
import '../controllers/aktivitas_controller.dart';

class AktivitasView extends GetView<AktivitasController> {
  final calenderC = Get.put(CalenderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarPage(
                      name: 'Aktivitas',
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30, left: 30, right: 15),
                      child: Text(
                        '${calenderC.tanggalview}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CalenderPage(
                name: 'Aktivitas',
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'List Aktivitas anda',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 62, 60)),
                    ),
                    Obx(() => controller.listData.isEmpty
                        ? Container(
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/empty.png',
                                    width: 250,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.listData.length,
                            itemBuilder: (context, index) {
                              // print(controller.listData.toString());
                              var time = DateFormat.Hm().format(DateTime.parse(
                                  controller.listData[index]['created_at']));
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.greenAccent)),
                                  child: ListTile(
                                    trailing: Icon(Icons.more_vert),
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.greenAccent,
                                        child: Icon(
                                          Icons.book,
                                          color: Colors.white,
                                        )),
                                    title: Text(
                                        '${controller.listData[index]['tanggal']}  ' +
                                            time),
                                    subtitle: Container(
                                      width: Get.width,
                                      child: Text(
                                          '${controller.listData[index]['keterangan']}'),
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () =>
            calenderC.showMyDialogAktivitas(context, calenderC.selectedDay),
        child: Icon(Icons.add),
      ),
    );
  }
}
