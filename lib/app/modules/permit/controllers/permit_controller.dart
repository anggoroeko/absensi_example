import 'dart:convert';

import 'package:absensi_example/app/data/service/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PermitController extends GetxController {
  final box = GetStorage();
  var listData = [].obs;

  Future listPermit(String date) async {
    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {"nik": box.read('nik'), "date": date};

    final response = await http.post(Uri.parse(BaseUrl.datapermit),
        headers: headers, body: bodyMsg);
    final data = jsonDecode(response.body);
    listData.value = data['results'];
  }

  @override
  void onInit() async {
    var tanggal = DateFormat("yyyy-MM-dd").format(DateTime.now());
    await listPermit(tanggal);
    super.onInit();
  }
}
