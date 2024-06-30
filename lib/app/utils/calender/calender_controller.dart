import 'dart:convert';

import 'package:absensi_example/app/data/service/api.dart';
import 'package:absensi_example/app/modules/aktivitas/controllers/aktivitas_controller.dart';
import 'package:absensi_example/app/modules/lembur/controllers/lembur_controller.dart';
import 'package:absensi_example/app/modules/permit/controllers/permit_controller.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CalenderController extends GetxController {
  late DateTime selectedDay;
  late DateTime focusedDay;
  late TextEditingController aktivitas;
  late TextEditingController permitext;
  late TextEditingController selamatext;
  late TextEditingController lemburext;
  late TextEditingController tglawal;
  late TextEditingController tglakhir;
  late TextEditingController jamawal;
  late TextEditingController jamakhir;
  var tanggal = ''.obs;
  var tanggalview = ''.obs;
  final box = GetStorage();
  final aktivitasC = Get.put(AktivitasController());
  final permitC = Get.put(PermitController());
  final lemburC = Get.put(LemburController());
  List<dynamic> _dataPermit = [].obs;
  var valPermit = '1'.obs;

  Future<void> showMyDialogAktivitas(context, DateTime selectedDay) async {
    String convertedDateTime = DateFormat.yMMMMd('en_US').format(selectedDay);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Form Aktivitas',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                convertedDateTime,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: Get.width,
              child: Column(
                children: [
                  TextField(
                    maxLines: 3,
                    controller: aktivitas,
                    decoration: InputDecoration(
                        hintText: "Keterangan",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('kembali'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Oke'),
              onPressed: () {
                simpanAktivitas(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialogPermit(context, DateTime selectedDay) async {
    String convertedDateTime = DateFormat.yMMMMd('en_US').format(selectedDay);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Form Permit',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                convertedDateTime,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: Get.width,
              child: Column(
                children: [
                  DateTimeField(
                    controller: tglawal,
                    decoration: InputDecoration(
                        hintText: "Tgl mulai",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    format: DateFormat("yyyy-MM-dd"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        return date;
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimeField(
                    controller: tglakhir,
                    decoration: InputDecoration(
                        hintText: "Tgl selesai",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    format: DateFormat("yyyy-MM-dd"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        return date;
                      } else {
                        print(currentValue);
                        return currentValue;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Obx(
                      () => DropdownButton(
                        underline: SizedBox(),
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                        isExpanded: true,
                        value: valPermit.value,
                        hint: Text("Jenis Permit"),
                        items: _dataPermit.map((item) {
                          return DropdownMenuItem(
                            child: Text(item['nama']),
                            value: item['id'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          valPermit.value = value.toString();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: permitext,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: "Keterangan",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('kembali'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Oke'),
              onPressed: () {
                simpanPermit(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialogLembur(context, DateTime selectedDay) async {
    String convertedDateTime = DateFormat.yMMMMd('en_US').format(selectedDay);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Form Lembur',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                convertedDateTime,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: Get.width,
              child: Column(
                children: [
                  DateTimeField(
                    controller: jamawal,
                    decoration: InputDecoration(
                        hintText: "Jam mulai",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    format: DateFormat("HH:mm"),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimeField(
                    controller: jamakhir,
                    decoration: InputDecoration(
                        hintText: "Jam selesai",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    format: DateFormat("HH:mm"),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: selamatext,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Selama ... /jam",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: lemburext,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: "Keterangan",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('kembali'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Oke'),
              onPressed: () {
                simpanLembur(context);
              },
            ),
          ],
        );
      },
    );
  }

  void getPermit() async {
    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final respose =
        await http.get(Uri.parse(BaseUrl.getMasterPermit), headers: headers);
    var listData = jsonDecode(respose.body);
    _dataPermit = listData;
  }

  void simpanLembur(BuildContext context) async {
    var tanggal = DateFormat("yyyy-MM-dd").format(selectedDay);

    if (jamawal.text == "") {
      Get.snackbar("Perhatian", "kolom jam awal wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (jamakhir.text == "") {
      Get.snackbar("Perhatian", "kolom jam akhir wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (selamatext.text == "") {
      Get.snackbar("Perhatian", "kolom Selama wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (lemburext.text == "") {
      Get.snackbar("Perhatian", "kolom keterangan wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {
      "nik": box.read('nik'),
      "jam_awal": jamawal.text,
      "jam_akhir": jamakhir.text,
      "selama": selamatext.text,
      "tanggal": tanggal,
      "keterangan": lemburext.text
    };

    final response = await http.post(Uri.parse(BaseUrl.inputLembur),
        headers: headers, body: bodyMsg);

    final data = jsonDecode(response.body);

    if (data['value'] == 1) {
      Get.snackbar("Success", "Proses anda berhasil. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 112, 224, 116),
          snackPosition: SnackPosition.TOP);
      await lemburC.listLembur(tanggal);
      Navigator.of(context).pop();
    } else {
      Get.snackbar("Perhatian", "Proses anda gagal. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
    }

    lemburext.text = "";
    jamawal.text = "";
    jamakhir.text = "";
    refresh();
  }

  void simpanPermit(BuildContext context) async {
    var tanggal = DateFormat("yyyy-MM-dd").format(selectedDay);

    if (tglawal.text == "") {
      Get.snackbar("Perhatian", "kolom tgl awal wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (tglakhir.text == "") {
      Get.snackbar("Perhatian", "kolom tgl akhir wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (permitext.text == "") {
      Get.snackbar("Perhatian", "kolom keterangan wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {
      "nik": box.read('nik'),
      "tgl_awal": tglawal.text,
      "tgl_akhir": tglakhir.text,
      "tipe_permit": valPermit.toString(),
      "tanggal": tanggal,
      "keterangan": permitext.text
    };

    final response = await http.post(Uri.parse(BaseUrl.inputPermit),
        headers: headers, body: bodyMsg);

    final data = jsonDecode(response.body);

    if (data['value'] == 1) {
      Get.snackbar("Sukses", "Proses anda berhasil. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 112, 224, 116),
          snackPosition: SnackPosition.TOP);
      await permitC.listPermit(tanggal);
      Navigator.of(context).pop();
    } else {
      Get.snackbar("Perhatian", "Proses anda gagal. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
    }

    permitext.text = "";
    tglawal.text = "";
    tglakhir.text = "";
    refresh();
  }

  void simpanAktivitas(BuildContext context) async {
    var tanggal = DateFormat("yyyy-MM-dd").format(selectedDay);

    if (aktivitas.text == "") {
      Get.snackbar("Perhatian", "kolom aktivitas wajib di isi",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
      return;
    }

    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {
      "user_id": box.read('user_id'),
      "tanggal": tanggal,
      "keterangan": aktivitas.text
    };

    final response = await http.post(Uri.parse(BaseUrl.inputAktivitas),
        headers: headers, body: bodyMsg);
    final data = jsonDecode(response.body);

    if (data['value'] == 1) {
      Get.snackbar("Sukses", "Proses anda berhasil. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 112, 224, 116),
          snackPosition: SnackPosition.TOP);
      await aktivitasC.listAktivitas(tanggal);
      Navigator.of(context).pop();
    } else {
      Get.snackbar("Perhatian", "Proses anda gagal. ",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 235, 61, 61),
          snackPosition: SnackPosition.TOP);
    }

    aktivitas.text = "";
    refresh();
  }

  @override
  void onInit() {
    aktivitas = TextEditingController();
    permitext = TextEditingController();
    tglawal = TextEditingController();
    tglakhir = TextEditingController();
    lemburext = TextEditingController();
    selamatext = TextEditingController();
    jamawal = TextEditingController();
    jamakhir = TextEditingController();
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    tanggalview.value = DateFormat.yMMMMd().format(selectedDay);
    getPermit();
    super.onInit();
  }
}
