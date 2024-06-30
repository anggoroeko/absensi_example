import 'dart:convert';

import 'package:absensi_example/app/data/service/api.dart';
import 'package:absensi_example/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'serviceClass.dart';
import '../modules/login/user_model.dart';

class AuthController extends GetxController {
  late TextEditingController username;
  late TextEditingController password;
  late String fcmtoken = '';
  var userJson = User().obs;
  var box = GetStorage();
  bool loading = false;

  void login() async {
    if (username.text == "") {
      Get.snackbar("Perhatian", "NIP wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (password.text == "") {
      Get.snackbar("Perhatian", "Password wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    loading = true;
    final body = {"username": username.text, "password": password.text};
    final response = (await serviceLogin(body))!;
    final data = jsonDecode(response.body);
    loading = false;

    if (data['value'] == 0) {
      Get.snackbar("Perhatian", "Maaf login gagal.",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    } else {
      Get.snackbar("Sukses", "Login anda berhasil. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 112, 224, 116),
          snackPosition: SnackPosition.TOP);

      final box = GetStorage();
      userJson.value = User.fromJson(data['user']);
      final noWa = userJson.value.noWa;
      final numberWa = noWa?.replaceFirst('+', '');

      // print(jsonEncode(userJson.value));
      // getFCMToken(userJson.value.nik);

      box.write('user_id', userJson.value.userId);
      box.write('nama', userJson.value.nama);
      box.write('jabatan', userJson.value.jabatan);
      box.write('nik', userJson.value.nik);
      box.write('nama_kantor', userJson.value.namaKantor);
      box.write('alamat_kantor', userJson.value.alamatKantor);
      box.write('access_token', userJson.value.accessToken);
      box.write('latitude', userJson.value.latitude);
      box.write('longitude', userJson.value.longitude);
      box.write('no_wa', numberWa);
      box.write('user_id_userinfo', userJson.value.userIdUserInfo);

      if (box.read('user_id') == "4164") {
        box.write('isAuth', true);
        Get.offNamed(Routes.HOME);
      } else {
        sendOtp(numberWa, userJson.value.userId);
      }

      refresh();
      update();
    }

    // final response = await http.post(Uri.parse(BaseUrl.login),
    //     body: {"username": username.text, "password": password.text});
    // final data = jsonDecode(response.body);

    // if (data['value'] == 0) {
    //   Get.snackbar("Perhatian", "Maaf login gagal.",
    //       colorText: Colors.white,
    //       backgroundColor: Color.fromARGB(255, 235, 61, 61),
    //       snackPosition: SnackPosition.TOP);
    //   return;
    // } else {
    //   Get.snackbar("Sukses", "Login anda berhasil. ",
    //       colorText: Colors.white,
    //       backgroundColor: Color.fromARGB(255, 112, 224, 116),
    //       snackPosition: SnackPosition.TOP);

    //   final box = GetStorage();
    //   userJson.value = User.fromJson(data['user']);

    //   // print(jsonEncode(userJson.value));
    //   getFCMToken(userJson.value.nik);

    //   box.write('user_id', userJson.value.userId);
    //   box.write('nama', userJson.value.nama);
    //   box.write('jabatan', userJson.value.jabatan);
    //   box.write('nik', userJson.value.nik);
    //   box.write('nama_kantor', userJson.value.namaKantor);
    //   box.write('alamat_kantor', userJson.value.alamatKantor);
    //   box.write('access_token', userJson.value.accessToken);
    //   box.write('latitude', userJson.value.latitude);
    //   box.write('longitude', userJson.value.longitude);
    //   box.write('no_wa', userJson.value.noWa);
    //   box.write('user_id_userinfo', userJson.value.userIdUserInfo);

    //   if (box.read('user_id') == "4164") {
    //     box.write('isAuth', true);
    //     Get.offNamed(Routes.HOME);
    //   } else {
    //     sendOtp(userJson.value.noWa, userJson.value.userId);
    //   }

    //   refresh();
    //   update();
    // }
  }

  logout() {
    box.write('user_id', '');
    box.write('nama', '');
    box.write('jabatan', '');
    box.write('nik', '');
    box.write('nama_kantor', '');
    box.write('alamat_kantor', '');
    box.write('isAuth', false);
    box.write('access_token', '');
    box.write('latitude', '');
    box.write('longitude', '');
    box.write('no_wa', '');
    Get.offAllNamed(Routes.LOGIN);
  }

  void getFCMToken(nik) async {
    var status = await OneSignal.shared.getDeviceState();
    // print(status!.userId);
    fcmtoken = status!.userId.toString();

    // var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {"fcmtoken": fcmtoken, "nik": nik};
    final response =
        await http.post(Uri.parse(BaseUrl.updatefcmtoken), body: bodyMsg);
    final data = jsonDecode(response.body);

    print(data);
  }

  void sendOtp(noWa, userId) async {
    final response = await http.post(Uri.parse(BaseUrl.sendOtp),
        body: {"number": noWa, "user_id": userId});
    final data = jsonDecode(response.body);

    if (data["status"] == "No Wa") {
      Get.snackbar("Perhatian", data["message"],
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
    } else {
      Get.snackbar("Perhatian", data["message"],
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 46, 225, 228),
          snackPosition: SnackPosition.TOP);
    }

    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;
    var dataOtp = {"timeOutOtp": endTime.toString()};
    Get.offNamed(Routes.OTP, parameters: dataOtp);

    return;
  }

  @override
  void onInit() {
    username = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
