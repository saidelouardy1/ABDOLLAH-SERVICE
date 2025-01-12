import 'package:get/get.dart';

import '../controllers/on_bordining_controller.dart';

class OnBordiningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBordiningController>(
      () => OnBordiningController(),
    );
  }
}
