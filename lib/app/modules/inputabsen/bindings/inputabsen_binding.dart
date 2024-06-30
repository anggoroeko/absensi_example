import 'package:get/get.dart';

import '../controllers/inputabsen_controller.dart';

class InputabsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputabsenController>(
      () => InputabsenController(),
    );
  }
}
