// ignore_for_file: unnecessary_new, unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:absensi_example/app/controllers/auth_controller.dart';
import 'package:absensi_example/app/data/service/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AbsensiController extends GetxController {
  final box = GetStorage();
  var listData = [].obs;
  bool isLoading = false;
  final authC = Get.put(AuthController());

  Future listAbsensi() async {
    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {"user_id": box.read('user_id_userinfo')};

    final response = await http.post(Uri.parse(BaseUrl.absen),
        headers: headers, body: bodyMsg);

    final data = jsonDecode(response.body); // JSON TO ARRAY

    if (data['value'] == "0") {
      Get.snackbar("Perhatian", data['message'],
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP);
      Timer _sessionTimer;
      _sessionTimer = new Timer(const Duration(seconds: 2), handleTimeOut);
    }
    listData.value = data['results'];
  }

  void handleTimeOut() {
    authC.logout();
  }

  Future<void> alertDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          titleTextStyle: TextStyle(color: Colors.black),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah anda yakin !!!.',
                  style: TextStyle(fontSize: 13.0),
                ),
                // Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : callabsen();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  callabsen() async {
    if (!isLoading) {
      isLoading = true;
      final bodyMsg = {"user_id": box.read('user_id_userinfo')};
      var headers = {
        'authorization': 'Bearer ' + box.read('access_token') + ''
      };

      final response = await http.post(Uri.parse(BaseUrl.callabsen),
          headers: headers, body: bodyMsg);
      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];
      if (value == 1) {
        Get.snackbar("Sukses", "Proses Syncronice Berhasil",
            colorText: Colors.white,
            backgroundColor: Color.fromARGB(255, 112, 224, 116),
            snackPosition: SnackPosition.TOP);
        await listAbsensi();
      } else {
        Get.snackbar("Perhatian", pesan,
            colorText: Colors.white,
            backgroundColor: Color.fromARGB(255, 235, 61, 61),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  @override
  void onInit() async {
    await listAbsensi();
    super.onInit();
  }
}
