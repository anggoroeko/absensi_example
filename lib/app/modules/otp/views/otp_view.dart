// ignore_for_file: must_be_immutable

import 'package:absensi_example/app/controllers/auth_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/appbarnotback.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/otp_controller.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpView extends GetView<OtpController> {
  final authC = Get.put(AuthController());
  final box = GetStorage();

  set otpTextStyles(List<TextStyle?> otpTextStyles) {}
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;
  String? timeOutOtp = Get.parameters['timeOutOtp'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarPage(
                name: "Verifikasi OTP",
              ),
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Text(
                      "Verifikasi OTP anda",
                      style: GoogleFonts.poppins().copyWith(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Ketikkan Nomor OTP di sini",
                      style: GoogleFonts.poppins().copyWith(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: OtpTextField(
                          numberOfFields: 6,
                          showFieldAsBox: false,
                          borderWidth: 4.0,
                          obscureText: true,
                          cursorColor: Colors.blue,
                          focusedBorderColor: Colors.blue,
                          borderColor: Colors.blue,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here if necessary
                          },
                          //runs when every textfield is filled
                          onSubmit: (String code) => controller.verifOtp(code),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CountdownTimer(
                        endTime: int.parse(timeOutOtp!),
                        widgetBuilder: (_, timeOutOtp) {
                          if (timeOutOtp == null) {
                            return Text(
                              "Time Out",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          } else {
                            int? timeMin = timeOutOtp.min;
                            int? timeSec = timeOutOtp.sec;
                            String timeMinStr = timeMin.toString();
                            String timeSecStr = timeSec.toString();

                            if (timeMin != null) {
                              if (timeMin < 10) {
                                timeMinStr = '0' + timeMin.toString();
                              }
                            } else {
                              timeMinStr = '00';
                            }

                            if (timeSec != null) {
                              if (timeSec < 10) {
                                timeSecStr = '0' + timeSec.toString();
                              }
                            }

                            return Text(
                              '$timeMinStr:$timeSecStr',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("Tidak menerima kode ?"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: TextButton(
                          onPressed: () => authC.sendOtp(
                              box.read('no_wa'), box.read('user_id')),
                          child: Text(
                            "Kirim ulang kode",
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
