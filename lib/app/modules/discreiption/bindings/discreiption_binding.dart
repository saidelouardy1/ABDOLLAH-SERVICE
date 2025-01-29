import 'package:get/get.dart';

import '../controllers/discreiption_controller.dart';

class DiscreiptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscreiptionController>(
      () => DiscreiptionController(),
    );
  }
}
