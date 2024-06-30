import 'package:absensi_example/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuAplikasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(_url) async {
      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $_url');
      }
    }

    return Container(
      color: Colors.white,
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: <Widget>[
            InkWell(
              onTap: () => Get.toNamed(Routes.ABSENSI),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.blue,
                        size: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'ABSEN',
                        style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () => Get.toNamed(Routes.PERMIT),
            //   child: Card(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.edit,
            //             color: Colors.blue,
            //             size: 50,
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             'PERMIT',
            //             style: GoogleFonts.poppins().copyWith(
            //                 color: Colors.black,
            //                 fontSize: 10,
            //                 fontWeight: FontWeight.bold),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // InkWell(
            //   onTap: () => Get.toNamed(Routes.LEMBUR),
            //   child: Card(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.date_range,
            //             color: Colors.blue,
            //             size: 50,
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             'LEMBUR',
            //             style: GoogleFonts.poppins().copyWith(
            //                 color: Colors.black,
            //                 fontSize: 10,
            //                 fontWeight: FontWeight.bold),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () => _launchUrl(Uri.parse('https://s.id/layanansdmrsp')),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.document_scanner_outlined,
                        color: Colors.blue,
                        size: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'LAPAK',
                        style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(Routes.PROFILE),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'PROFILE',
                        style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(Routes.SETTING),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings_applications,
                        color: Colors.blue,
                        size: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'PENGATURAN',
                        style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
