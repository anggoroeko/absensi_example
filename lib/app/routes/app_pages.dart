import 'package:absensi_example/app/modules/otp/bindings/otp_binding.dart';
import 'package:absensi_example/app/modules/otp/views/otp_view.dart';
import 'package:get/get.dart';

import 'package:absensi_example/app/modules/absensi/bindings/absensi_binding.dart';
import 'package:absensi_example/app/modules/absensi/views/absensi_view.dart';
import 'package:absensi_example/app/modules/aktivitas/bindings/aktivitas_binding.dart';
import 'package:absensi_example/app/modules/aktivitas/views/aktivitas_view.dart';
import 'package:absensi_example/app/modules/home/bindings/home_binding.dart';
import 'package:absensi_example/app/modules/home/views/home_view.dart';
import 'package:absensi_example/app/modules/inputabsen/bindings/inputabsen_binding.dart';
import 'package:absensi_example/app/modules/inputabsen/views/inputabsen_view.dart';
import 'package:absensi_example/app/modules/lembur/bindings/lembur_binding.dart';
import 'package:absensi_example/app/modules/lembur/views/lembur_view.dart';
import 'package:absensi_example/app/modules/login/bindings/login_binding.dart';
import 'package:absensi_example/app/modules/login/views/login_view.dart';
import 'package:absensi_example/app/modules/permit/bindings/permit_binding.dart';
import 'package:absensi_example/app/modules/permit/views/permit_view.dart';
import 'package:absensi_example/app/modules/profile/bindings/profile_binding.dart';
import 'package:absensi_example/app/modules/profile/views/profile_view.dart';
import 'package:absensi_example/app/modules/setting/bindings/setting_binding.dart';
import 'package:absensi_example/app/modules/setting/views/setting_view.dart';
import 'package:absensi_example/app/modules/ubahpassword/bindings/ubahpassword_binding.dart';
import 'package:absensi_example/app/modules/ubahpassword/views/ubahpassword_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.UBAHPASSWORD,
      page: () => UbahpasswordView(),
      binding: UbahpasswordBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS,
      page: () => AktivitasView(),
      binding: AktivitasBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI,
      page: () => AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: _Paths.INPUTABSEN,
      page: () => InputabsenView(),
      binding: InputabsenBinding(),
    ),
    GetPage(
      name: _Paths.PERMIT,
      page: () => PermitView(),
      binding: PermitBinding(),
    ),
    GetPage(
      name: _Paths.LEMBUR,
      page: () => LemburView(),
      binding: LemburBinding(),
    ),
  ];
}
