import 'package:absensi_example/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/appbarpage.dart';
import '../controllers/absensi_controller.dart';

class AbsensiView extends GetView<AbsensiController> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showInDialog() async {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Permintaan Akses'),
            content: const Text(
                'Harap Berikan akses kamera dan mikropon / Permissions for camera and microphone!'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  openAppSettings();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        Get.toNamed(Routes.INPUTABSEN);
      }
    }

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarPage(
                  name: 'Data Absensi',
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 15),
                  child: IconButton(
                      onPressed: () => controller.alertDialog(context),
                      icon: Icon(
                        Icons.refresh,
                        size: 30,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: DefaultTextStyle(
                style: GoogleFonts.poppins().copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Hari",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Tanggal",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "In",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Out",
                      ),
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: Text(
                    //     "Flag",
                    //     textAlign: TextAlign.end,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                child: controller.listData.isNotEmpty
                    ? Center(
                        child: Text('data absen kosong'),
                      )
                    : Obx(
                        () => ListView.builder(
                            itemCount: controller.listData.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: DefaultTextStyle(
                                        style: GoogleFonts.poppins().copyWith(
                                            color: controller.listData[i]
                                                        ['flg_hadir'] ==
                                                    'OFF'
                                                ? Colors.red[900]
                                                : Colors.black,
                                            fontSize: 12),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                controller.listData[i]
                                                        ['hari'] ??
                                                    '',
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                controller.listData[i]['tgl'] ??
                                                    '',
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                controller.listData[i]['in'] ??
                                                    '',
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                controller.listData[i]['out'] ??
                                                    '',
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 2,
                                            //   child: Text(
                                            //     controller.listData[i]
                                            //             ['flg_hadir'] ??
                                            //         '',
                                            //     textAlign: TextAlign.end,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          _showInDialog();
        },
      ),
    );
  }
}
