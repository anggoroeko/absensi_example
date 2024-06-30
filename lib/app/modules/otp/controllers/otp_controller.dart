import 'dart:convert';

import 'package:absensi_example/app/data/service/api.dart';
import 'package:absensi_example/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  final box = GetStorage();

  void verifOtp(code) async {
    final response = await http.get(Uri.parse(BaseUrl.verifOtp +
        '?user_id=' +
        box.read("user_id") +
        '&otp_code=' +
        code));

    final data = jsonDecode(response.body);
    if (data["message"] == "success") {
      box.write('isAuth', true);
      Get.offNamed(Routes.HOME);
    } else {
      box.write('isAuth', false);
    }
  }
}
