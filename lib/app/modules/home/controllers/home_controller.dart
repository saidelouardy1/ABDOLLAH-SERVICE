import 'dart:async';
import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/modules/home/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseService firebaseService = FirebaseService();

class HomeController extends GetxController {
  RxString photoUser = "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png".obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingService = false.obs;
  RxInt likes = 0.obs;
  RxList<QueryDocumentSnapshot> AllService = <QueryDocumentSnapshot>[].obs;
  RxList<String> AddIdUser = <String>[].obs;



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
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
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
  /////////////////////: phone call

  void makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch $url");
    }
  }

  void Logout() {
    firebaseService.signOut();
  }
   
  // Future<void> Dolikes(String idDocument) async {
  //   CollectionReference servicesLikes = FirebaseFirestore.instance.collection('AllService');
  //   String currentId = FirebaseAuth.instance.currentUser!.uid;
  //   try {
  //     DocumentSnapshot docSnapshot = await servicesLikes.doc(idDocument).get();
  //     if (docSnapshot.exists) {
  //       List<dynamic> likedUsers = docSnapshot['PersonWhoDoLikes'] ?? [];
  //       if (likedUsers.contains(currentId)) {
  //         await servicesLikes.doc(idDocument).update({
  //           'wonder': FieldValue.increment(-1),
  //           'PersonWhoDoLikes': FieldValue.arrayRemove([currentId])
  //         });
  //         print('Like removed successfully');
  //       } else {
  //         await servicesLikes.doc(idDocument).update({
  //           'wonder': FieldValue.increment(1),
  //           'PersonWhoDoLikes': FieldValue.arrayUnion([currentId])
  //         });
  //         print('Like added successfully');
  //       }
  //     }
  //   } catch (e) {
  //     print('Error updating like: $e');
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    firebaseService.fetchDataUser();
    firebaseService.fetchAllservice();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // timer = Timer.periodic(Duration(seconds: 4), (timer) {
    //   next_PageViwe();
    // });
    // });
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
