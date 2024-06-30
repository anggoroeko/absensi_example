// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:absensi_example/app/data/service/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class LemburController extends GetxController {
  final box = GetStorage();
  var listData = [].obs;

  Future<void> listLembur(String date) async {
    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {"nik": box.read('nik'), "date": date};

    final response = await http.post(Uri.parse(BaseUrl.dataLembur),
        headers: headers, body: {"nik": box.read('nik'), "date": date});
    final data = jsonDecode(response.body);
    listData.value = data['results'];
  }

  @override
  void onInit() async {
    var tanggal = DateFormat("yyyy-MM-dd").format(DateTime.now());
    await listLembur(tanggal);
    super.onInit();
  }
}
