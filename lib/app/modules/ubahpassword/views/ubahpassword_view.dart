import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../utils/appbarpage.dart';
import '../../../utils/userCard.dart';
import '../controllers/ubahpassword_controller.dart';

class UbahpasswordView extends GetView<UbahpasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Ubah password',
      //       style: GoogleFonts.poppins().copyWith(
      //           color: Colors.white,
      //           fontSize: 15,
      //           fontWeight: FontWeight.bold)),
      //   centerTitle: false,
      // ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarPage(
                name: 'Ubah Password',
              ),
              SizedBox(
                height: 20,
              ),
              UserCardPage(),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextField(
                      obscureText: true,
                      controller: controller.passwordlama,
                      decoration: InputDecoration(
                          hintText: "Masukan Password lama anda",
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      controller: controller.passwordbaru,
                      decoration: InputDecoration(
                          hintText: "Masukan Password baru anda",
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      controller: controller.passwordconfirm,
                      decoration: InputDecoration(
                          hintText: "Masukan Confirm Password  anda",
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () => controller.ubahPassword(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text("Simpan",
                  style: GoogleFonts.poppins().copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
