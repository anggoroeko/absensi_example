// ignore_for_file: unused_import, unused_local_variable

import 'package:absensi_example/app/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../utils/appbarpage.dart';
import '../../../utils/userCard.dart';
import '../controllers/setting_controller.dart';
// import 'package:absensi/facerecognition.dart';
import 'package:absensi_example/app/controllers/checkVersion.dart';

class SettingView extends GetView<SettingController> {
  final versionC = Get.put(CheckVersionController());

  @override
  Widget build(BuildContext context) {
    versionC.checkVersion(context);
    final box = GetStorage();

    return Scaffold(
        body: Container(
      child: Column(
        children: [
          AppBarPage(
            name: 'Pengaturan',
          ),
          SizedBox(
            height: 20,
          ),
          UserCardPage(),
          // ListTile(
          //   leading: Icon(
          //     Icons.book,
          //     color: Colors.blue,
          //   ),
          //   title: Text('Panduan aplikasi'),
          //   trailing: Icon(
          //     Icons.arrow_right_outlined,
          //     size: 40,
          //   ),
          // ),
          ListTile(
            title: Text(
              "Keamanan",
              style: GoogleFonts.poppins().copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 219, 219, 219)))),
              )
            ],
          ),
          // ListTile(
          //     leading: Icon(
          //       Icons.face_retouching_natural,
          //       color: Colors.blue,
          //     ),
          //     title: Text("Pendaftaran Face Recognition",
          //         style: GoogleFonts.poppins().copyWith(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14,
          //         )),
          //     // onTap: () => Get.toNamed(Routes.FACERECOGNITION),
          //     onTap: () async {
          //       WidgetsFlutterBinding.ensureInitialized();
          //       cameras = await availableCameras();

          //       Navigator.of(context)
          //           .push(MaterialPageRoute(builder: (_) => RegisterFace()));
          //     }),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 219, 219, 219)))),
          ),
          InkWell(
            onTap: () => Get.toNamed(Routes.UBAHPASSWORD),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.lock_circle,
                color: Colors.blue,
              ),
              title: Text("Ubah Password",
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
              trailing: Icon(
                Icons.arrow_right_outlined,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
