import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/appbarpage.dart';
import '../../../utils/calender/calender_controller.dart';
import '../../../utils/calender/table_calender.dart';
import '../controllers/permit_controller.dart';

class PermitView extends GetView<PermitController> {
  final calenderC = Get.put(CalenderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarPage(
                      name: 'Permit',
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30, left: 30, right: 15),
                      child: Text(
                        '${calenderC.tanggalview}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CalenderPage(
                name: 'Permit',
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'List Permit anda',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 62, 60)),
                    ),
                    Obx(() => controller.listData.isEmpty
                        ? Container(
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/empty.png',
                                    width: 250,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.listData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.greenAccent)),
                                  child: ListTile(
                                    trailing: Icon(Icons.more_vert),
                                    leading: CircleAvatar(
                                      child: controller.listData[index]
                                                  ['status'] ==
                                              '0'
                                          ? Icon(
                                              Icons.contact_support_outlined,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.task,
                                              color: Colors.white,
                                            ),
                                      backgroundColor: controller
                                                  .listData[index]['status'] ==
                                              '0'
                                          ? Colors.greenAccent
                                          : Colors.green,
                                    ),
                                    title: Text(
                                      '${controller.listData[index]['tgl_mulai']} s/d ${controller.listData[index]['tgl_akhir']} ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${controller.listData[index]['nama_permit']}  '
                                              '${controller.listData[index]['jml_hari']} HARI',
                                              style: TextStyle(fontSize: 12)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              '${controller.listData[index]['keterangan']}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () =>
            calenderC.showMyDialogPermit(context, calenderC.selectedDay),
        child: Icon(Icons.add),
      ),
    );
  }
}
