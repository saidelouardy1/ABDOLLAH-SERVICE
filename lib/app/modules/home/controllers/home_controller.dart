import 'dart:async';
import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList image_PageViwe = [
    Images_Icon.background,
    Images_Icon.backgroundOne,
    Images_Icon.backgroundTow,
    Images_Icon.backgroundThree
  ].obs;
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
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void startAutoScroll() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      next_PageViwe();
    });
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(milliseconds: 100), () {
      startAutoScroll();
    });
  }

  @override
  void onClose() {
    timer?.cancel(); 
    pageController.dispose();
    super.onClose();
  }
}
