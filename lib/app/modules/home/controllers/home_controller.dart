import 'dart:async';
import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/modules/home/service/firebase_service.dart';
import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseService firebaseService = FirebaseService();
  RxString photoUser = "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png".obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingService = false.obs;
  RxList<QueryDocumentSnapshot> AllService = <QueryDocumentSnapshot>[].obs;
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
///////////////////////////////////////////// firebase service
 ///////////////////////////////// LogOut
 void logout() async {
    await firebaseService.signOut();
    Get.offAllNamed(Routes.AUTHENTICATION);
  }


  @override
  void onReady() {
    super.onReady();
    // Future.delayed(Duration(milliseconds: 100), () {
    //   startAutoScroll();
    // });
     firebaseService.fetchDataUser();
    firebaseService.fetchAllservice();
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
