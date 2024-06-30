import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../utils/appbarpage.dart';
import '../controllers/profile_controller.dart';
import 'package:absensi_example/app/controllers/checkVersion.dart';

class ProfileView extends GetView<ProfileController> {
  final versionC = Get.put(CheckVersionController());

  @override
  Widget build(BuildContext context) {
    versionC.checkVersion(context);
    final box = GetStorage();

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBarPage(
              name: 'Profile',
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              maxRadius: 80,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: box.read('nik'),
                        prefixIcon: Icon(
                          Icons.card_giftcard,
                          color: Colors.blue,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: box.read('nama'),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: box.read('nama_kantor'),
                        prefixIcon: Icon(
                          Icons.home,
                          color: Colors.blue,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: box.read('alamat_kantor'),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.blue,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: box.read('jabatan'),
                        prefixIcon: Icon(
                          Icons.card_membership,
                          color: Colors.blue,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
