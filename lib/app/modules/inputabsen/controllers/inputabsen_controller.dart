// ignore_for_file: unused_local_variable, unnecessary_new, prefer_final_fields, unused_import, unused_field

import 'dart:async';
import 'dart:convert';
import 'package:absensi_example/app/controllers/auth_controller.dart';
import 'package:absensi_example/app/routes/app_pages.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/service/api.dart';
import 'package:flutter/services.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:camera/camera.dart';
import 'package:absensi_example/app/controllers/deviceInfo.dart';

class InputabsenController extends GetxController {
  var jam = ''.obs;
  Position? currentPosition;
  var currentLocationAddress = ''.obs;
  var longtitude = ''.obs;
  var latitude = ''.obs;
  var box = GetStorage();
  final authC = Get.put(AuthController());
  final deviceIdC = Get.put(DeviceInfoController());
  final _secureStorage = FlutterSecureStorage();
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  Map<MarkerId, Marker> markers = {};
  List<LatLng> polylineCoordinates = [
    LatLng(-6.206895, 106.885634),
    LatLng(-6.206005, 106.885659),
    LatLng(-6.205991, 106.885137),
    LatLng(-6.204954, 106.885096),
    LatLng(-6.204954, 106.885659),
    LatLng(-6.202387, 106.885741),
    LatLng(-6.202483, 106.882926),
    LatLng(-6.204135, 106.883050),
    LatLng(-6.205664, 106.884080),
    LatLng(-6.205718, 106.884766),
    LatLng(-6.206688, 106.884959),
    LatLng(-6.206895, 106.885634),
  ];

  double _originLatitude = -6.206895, _originLongitude = 106.885634;
  double _destLatitude = -6.206895, _destLongitude = 106.885634;

  void startJam() {
    Timer.periodic(Duration(seconds: 1), (_) {
      var tgl = DateTime.now();
      var formatedjam = DateFormat.Hms().format(tgl);
      jam.value = formatedjam;
    });
  }

  Future<int> inputAbsen(flag) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String deviceId = await deviceIdC.getUniqueDeviceId();

    // var statusDevice = await OneSignal.shared.getDeviceState();
    // // print("deviceId " + deviceId);
    // print(statusDevice);

    var headers = {'authorization': 'Bearer ' + box.read('access_token') + ''};
    final bodyMsg = {
      "nik": box.read('nik'),
      "flag": flag,
      "user_id": box.read('user_id_userinfo'),
      "serial_number": "MOBAPP982346",
      "device_id": deviceId
    };

    final response = await http.post(Uri.parse(BaseUrl.inputabsen),
        headers: headers, body: bodyMsg);
    final data = jsonDecode(response.body);

    int value = int.parse(data['value']);

    switch (value) {
      //:: SESSION TIMEOUT
      case 0:
        Get.snackbar("Perhatian", data['message'],
            colorText: Colors.white,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.TOP);
        Timer _sessionTimer;
        _sessionTimer = new Timer(const Duration(seconds: 2), handleTimeOut);
        break;

      //:: SUCCESS
      case 1:
        Get.snackbar("Selamat", data['message'],
            colorText: Colors.white,
            backgroundColor: Color.fromARGB(255, 112, 224, 116),
            snackPosition: SnackPosition.TOP);
        Get.offNamed(Routes.INPUTABSEN);
        break;

      //:: BEYOND THE TERM (DILUAR JANGKAUAN)
      case 2:
        Get.snackbar("Perhatian", data['message'],
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
        break;
      default:
    }

    return value;
  }

  void handleTimeOut() {
    authC.logout();
  }

  void biometricInput(flag) async {
    String _authorized = 'Not Authorized';
    bool didAuthenticate = false;

    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    List<BiometricType> availableBiometrics = [];

    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print(e);
    }

    if (!canCheckBiometrics) {
      return;
    }

    // Map<String, String> allValues = await _secureStorage.readAll();
    // if (allValues.isEmpty) {
    //   print('Security has been changed!');
    //   return;
    //   // Lakukan sesuatu di sini, seperti log out pengguna
    // } else {
    try {
      didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to be absence',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Authentication required!',
              biometricHint: '',
              cancelButton: 'Cancel',
            ),
          ]);
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
        _authorized = 'Error - ${e.message}';
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        _authorized = 'Error - ${e.message}';
      }
      return;
    }
    // }

    if (didAuthenticate) {
      inputAbsen(flag);
    } else {
      print(_authorized);
    }
  }

  getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      currentPosition = position;
      getCurrentLocationAddress();
      // loadCamera();
    }).catchError((e) {
      print(e);
    });
  }

  getCurrentLocationAddress() async {
    try {
      latitude.value = currentPosition!.latitude.toString();
      longtitude.value = currentPosition!.longitude.toString();
      print('lat ' + latitude.value + ' long ' + longtitude.value);
      List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = listPlaceMarks[0];
      currentLocationAddress.value =
          '${place.locality}, ${place.postalCode}, ${place.country}';

      print(currentLocationAddress.value);
    } catch (e) {
      print(e);
    }
  }

  loadCamera() async {
    cameras = await availableCameras();

    if (cameras != null) {
      controller = CameraController(cameras![1], ResolutionPreset.low);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        // if (!mounted) {
        //   return;
        // }
        // setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  Map<PolylineId, Polyline> polylines = {};

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
  }

  _getPolyline() async {
    String googleAPiKey = "AIzaSyBwL4D6rFKHZ5UNLmKqdNzBpJSyUsKiEzQ";
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  void onInit() {
    startJam();
    getCurrentLocation();
    loadCamera();
    _getPolyline();
    super.onInit();
  }
}
