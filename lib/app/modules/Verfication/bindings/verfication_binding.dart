import 'package:get/get.dart';

import '../controllers/verfication_controller.dart';

class VerficationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerficationController>(
      () => VerficationController(),
    );
  }
}
