import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCardPage extends StatelessWidget {
  const UserCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.all(15),
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.png'),
                    maxRadius: 50,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  DefaultTextStyle(
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.black87, fontSize: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('NIK'),
                            SizedBox(
                              width: 42,
                            ),
                            Text(box.read('nik') ?? "-")
                          ],
                        ),
                        Row(
                          children: [
                            Text('Nama'),
                            SizedBox(
                              width: 22,
                            ),
                            Text(box.read('nama') ?? "-")
                          ],
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        // Row(
                        //   children: [
                        //     Text('Jabatan'),
                        //     SizedBox(
                        //       width: 6,
                        //     ),
                        //     Text(box.read('jabatan') ?? "-")
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
