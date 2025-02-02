import 'dart:async';
import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList image_PageViwe = [
    Images_Icon.background,
    Images_Icon.backgroundOne,
    Images_Icon.backgroundTow,
    Images_Icon.backgroundThree
  ].obs;

  List<String> get TextOne => [
        "TextOne_1".tr,
        "TextOne_2".tr,
        "TextOne_3".tr,
        "TextOne_4".tr,
      ];

  List<String> get TextTow => [
        "TextTow_1".tr,
        "TextTow_2".tr,
        "TextTow_3".tr,
        "TextTow_4".tr,
      ];

  PageController pageController = PageController();
  Timer? timer;

  void next_PageViwe() {
    if (currentIndex.value < image_PageViwe.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0;
    }
    pageController.animateToPage(
      currentIndex.value,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeIn,
    );
  }

  void startAutoScroll() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      next_PageViwe();
    });
  }

  /////////////// drawer
  List<String> get title_Drawer =>
      ['Home'.tr, 'update'.tr, 'notification'.tr, 'payment'.tr, 'logout'.tr];
  RxList Icons_title_Drawer = [
    Images_Icon.home,
    Images_Icon.upate,
    Images_Icon.Notification,
    Images_Icon.Wallet,
    Images_Icon.Logout
  ].obs;

  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        if (user.providerData
            .any((element) => element.providerId == 'google.com')) {
          GoogleSignIn googleSignIn = GoogleSignIn();
          await googleSignIn.signOut();
          await FirebaseAuth.instance.signOut();
        }
        else if (user.providerData
            .any((element) => element.providerId == 'facebook.com')) {
          final facebookLogin = FacebookAuth.instance;
          await facebookLogin.logOut();
          await FirebaseAuth.instance.signOut();
        }
        else if (user.providerData
            .any((element) => element.providerId == 'password')) {
          await FirebaseAuth.instance.signOut();
        }
        else if (user.providerData
            .any((element) => element.providerId == 'apple.com')) {
          await FirebaseAuth.instance.signOut();
        }
        Get.offAllNamed(Routes.AUTHENTICATION);
      } catch (e) {
        print('Error signing out: $e');
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Future.delayed(Duration(milliseconds: 100), () {
    //   startAutoScroll();
    // });
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
