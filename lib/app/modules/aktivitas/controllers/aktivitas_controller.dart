import 'dart:convert';
import 'package:absensi_example/app/data/service/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AktivitasController extends GetxController {
  final box = GetStorage();
  var listData = [].obs;

  Future listAktivitas(String date) async {
    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {"user_id": box.read('user_id'), "date": date};

    final response = await http.post(Uri.parse(BaseUrl.dataaktivitas),
        headers: headers, body: bodyMsg);
    final data = jsonDecode(response.body);
    print(data['results']);
    listData.value = data['results'];
  }

  @override
  void onInit() async {
    var tanggal = DateFormat("yyyy-MM-dd").format(DateTime.now());
    await listAktivitas(tanggal);
    super.onInit();
  }
}
