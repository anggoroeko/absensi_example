import 'package:absensi_example/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPage extends StatelessWidget {
  const AppBarPage({Key? key, String? name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthC = Get.put(AuthController());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20,
          ),
          Text(
            'Attendance App',
            style: GoogleFonts.poppins().copyWith(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 25,
          ),
          InkWell(
            onTap: () => AuthC.logout(),
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
