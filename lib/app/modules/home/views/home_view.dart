import 'package:absensi_example/app/controllers/auth_controller.dart';
import 'package:absensi_example/app/controllers/checkVersion.dart';
import 'package:absensi_example/app/utils/appbar.dart';
import 'package:absensi_example/app/utils/slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/menu.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.put(AuthController());
  final box = GetStorage();
  final versionC = Get.put(CheckVersionController());

  @override
  Widget build(BuildContext context) {
    versionC.checkVersion(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarPage(),
            VerticalSlider(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(15),
                  // height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                            maxRadius: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hallo, ${box.read('nama')}',
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  // Text(
                                  //   'Jabatan ',
                                  //   style: GoogleFonts.poppins().copyWith(
                                  //       color: Colors.black54,
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // Text(
                                  //   box.read('jabatan') ?? "-",
                                  //   style: GoogleFonts.poppins().copyWith(
                                  //       color: Colors.black54,
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ))),
            ),
            MenuAplikasi()
          ],
        ),
      ),
    ));
  }
}
