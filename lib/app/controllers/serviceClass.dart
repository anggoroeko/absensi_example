// import 'dart:convert';
// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer';
// import 'dart:io';
import 'package:absensi_example/app/data/service/api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> serviceLogin(data) async {
  Timer? _timer;
  late double _progress;

  http.Response? response;
  try {
    EasyLoading.show(status: "Loading");
    response = await http.post(Uri.parse(BaseUrl.login), body: data);
    EasyLoading.dismiss();
  } catch (e) {
    log(e.toString());
  }
  return response;
}
