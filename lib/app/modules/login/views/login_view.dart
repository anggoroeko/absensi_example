// ignore_for_file: must_be_immutable, unused_field, unused_local_variable, unused_import

import 'dart:async';

import 'package:absensi_example/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/login_controller.dart';
// import 'package:absensi/app/controllers/serviceClass.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.put(AuthController());
  Timer? _timer;
  late double _progress;

  @override
  Widget build(BuildContext context) {
    var _isLoading = false;
    return Scaffold(
        // backgroundColor: Colors.blue,
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Absensi Online",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      "assets/images/logo_rsp.png",
                                      width: 150,
                                      height: 100,
                                    ),
                                  )
                                ],
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: authC.username,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          hintText: "NIP",
                          hoverColor: Colors.blue,
                          hintStyle: GoogleFonts.poppins()
                              .copyWith(color: Colors.black54, fontSize: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(150))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: authC.password,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.blue,
                          ),
                          hintText: "Password",
                          hintStyle: GoogleFonts.poppins()
                              .copyWith(color: Colors.black54, fontSize: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(150))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // });
                        // _progress = 0;
                        // _timer?.cancel();
                        // _timer = Timer.periodic(
                        //     const Duration(milliseconds: 100), (Timer timer) {
                        //   EasyLoading.showProgress(_progress,
                        //       status:
                        //           '${(_progress * 100).toStringAsFixed(0)}%');
                        //   _progress += 0.03;

                        //   if (_progress >= 1) {
                        //     _timer?.cancel();
                        //     authC.login();
                        //     EasyLoading.dismiss();
                        //   }
                        // });
                        authC.login();
                      },
                      child: Container(
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.lightBlue),
                        child: Center(
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins().copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
