import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:abdollah_srevice/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  var progress = 0.0.obs; 
  final _storage = GetStorage();
  

  @override
  void onInit() {
    super.onInit();
    startProgress();
  }

  void startProgress() {
    progress.value = 0.0;
    updateProgress();
  }

  void updateProgress() async {
    while (progress.value < 1.0) {
      await Future.delayed(Duration(milliseconds: 300));
      progress.value += 0.05;
    }
    progress.value = 1.0;

    checkOnboarding();
  }

  void checkOnboarding() {
    bool isFirstInstallation = _storage.read('isFirstInstallation') ?? true;

    if (isFirstInstallation) {
      _storage.write('isFirstInstallation', false);
      Get.offAllNamed(Routes.ON_BORDINING);
    } else {
     FirebaseAuth.instance.currentUser == null ? Get.offAllNamed(Routes.AUTHENTICATION) : Get.offAllNamed(Routes.NAVIGATORBAR_BOTTOM)  ;
    }
  }
}
