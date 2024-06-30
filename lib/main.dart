import 'dart:io';
import 'package:absensi_example/app/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await OneSignal.shared.setAppId("205ebac3-202f-4a4a-b1f1-0cc7e276a77e");
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              color: Colors.white,
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              title: "Application",
              initialRoute:
                  (box.read('isAuth') == false || box.read('isAuth') == null)
                      ? Routes.LOGIN
                      : Routes.HOME,
              getPages: AppPages.routes,
            );
          }
          return Loading();
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
