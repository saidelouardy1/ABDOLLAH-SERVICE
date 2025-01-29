import 'package:get/get.dart';

import '../controllers/navigatorbar_bottom_controller.dart';

class NavigatorbarBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorbarBottomController>(
      () => NavigatorbarBottomController(),
    );
  }
}
