// ignore_for_file: unnecessary_new, unused_local_variable

// import 'package:absensi/facerecognition.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/appbarpage.dart';
import '../controllers/inputabsen_controller.dart';
import 'package:absensi_example/app/controllers/checkVersion.dart';
import 'package:camera/camera.dart';

class InputabsenView extends GetView<InputabsenController> {
  // final bool _isAuthenticating = false;
  final versionC = Get.put(CheckVersionController());

  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    void _onMapCreated(GoogleMapController controller) async {
      mapController = controller;
    }

    versionC.checkVersion(context);

    Future<void> _showInDialog(flag) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Ambil foto wajah dan tekan fingerprint',
              style: GoogleFonts.poppins().copyWith(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                //   child: ListBody(
                //     children: <Widget>[
                //       // Text('Facerecognition | Fingerprint'),
                //       // new Image.asset(
                //       //   'assets/slider/frame_2.png',
                //       //   width: 200.0,
                //       //   height: 140.0,
                //       //   fit: BoxFit.cover,
                //       // ),
                //     ],
                //   ),
                child: Column(children: [
              if (controller.image == null)
                Container(
                    width: 200,
                    // height: 330,
                    child: controller.controller == null
                        ? Center(child: Text("Loading Camera..."))
                        : !controller.controller!.value.isInitialized
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : CameraPreview(controller.controller!)),
              if (controller.image == null)
                ElevatedButton.icon(
                  //image capture button
                  onPressed: () async {
                    try {
                      if (controller.controller != null) {
                        //check if contrller is not null
                        if (controller.controller!.value.isInitialized) {
                          //check if controller is initialized
                          controller.image = await controller.controller!
                              .takePicture(); //capture image
                        }
                      }
                    } catch (e) {
                      print(e); //show error
                    }

                    Navigator.pop(context);
                    _showInDialog(flag);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Ambil Foto"),
                ),
              Container(
                //show captured image
                padding: EdgeInsets.all(30),
                child: controller.image == null
                    ? Text("Belum ada foto")
                    : Image.file(
                        File(controller.image!.path),
                        width: 200,
                      ),
                //display captured image
              )
            ])),
            actions: <Widget>[
              // TextButton(
              //     onPressed: () async {
              //       Navigator.pop(context, 'Face');
              //       WidgetsFlutterBinding.ensureInitialized();
              //       cameras = await availableCameras();

              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (_) => RegisterFace(
              //                 flaging: flag,
              //               )));
              //     },
              //     child: Icon(
              //       Icons.face_retouching_natural,
              //       color: Colors.blue,
              //     )),
              // TextButton(onPressed: () {}, child: Text("|")),

              if (controller.image != null)
                TextButton(
                    onPressed: () {
                      controller.biometricInput(flag);
                      Navigator.pop(context, 'Finger');
                      controller.image = null;
                    },
                    child: Icon(
                      Icons.fingerprint,
                      color: Colors.blue,
                    )),

              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  controller.image = null;
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarPage(
                name: 'Input Absen',
              ),
              Container(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Obx(
                  () => (controller.jam.value.isEmpty)
                      ? CircularProgressIndicator()
                      : Text(
                          'Jam : ' + controller.jam.value,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(
              children: [
                Obx(
                  () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: controller.latitude.value == '' ||
                                  controller.longtitude.value == ''
                              ? Center(
                                  child: InkWell(
                                    onTap: () =>
                                        controller.getCurrentLocation(),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                          child: Text(
                                        'GET LOKASI ANDA',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                )
                              : GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(-6.206895, 106.885634),
                                    zoom: 12,
                                  ),
                                  myLocationEnabled: true,
                                  tiltGesturesEnabled: true,
                                  compassEnabled: true,
                                  scrollGesturesEnabled: true,
                                  zoomGesturesEnabled: true,
                                  onMapCreated: _onMapCreated,
                                  markers:
                                      Set<Marker>.of(controller.markers.values),
                                  polylines: Set<Polyline>.of(
                                      controller.polylines.values),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                // onTap: () => controller.biometricInput("MASUK"),
                onTap: () {
                  _showInDialog("MASUK");
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    'IN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              InkWell(
                // onTap: () => controller.biometricInput("KELUAR"),
                onTap: () {
                  _showInDialog("KELUAR");
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    'OUT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
