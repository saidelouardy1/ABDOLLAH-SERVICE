import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/modules/home/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Obx(() => Drawer(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                width: Get.width,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(homeController.photoUser.value),
                              radius: 30,
                            ),
                            SizedBox(height: 8),
                            Text(
                              homeController.userName.value,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Fontsized.DisplayMidume,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 2),
                            Text(
                              homeController.userEmail.value,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Fontsized.SizedSmall,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: List.generate(
                          5,
                          (index) => ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.back();
                                  break;
                                case 1:
                                  print("update");
                                  break;
                                case 2:
                                  print("notife");
                                  break;
                                case 3:
                                  print("pay");
                                  break;
                                case 4:
                                  homeController.Logout();
                                  break;
                              }
                            },
                            leading: SvgPicture.asset(
                              homeController.Icons_title_Drawer[index],
                              color: index == 4 ? Colors.red : Colors.black,
                            ),
                            title: Text(
                              homeController.title_Drawer[index].tr,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: Fontsized.fontsMidume,
                                color: index == 4 ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        body: Obx(
          () => homeController.isLoading.value
              ? Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: 35, bottom: 30),
                    color: Colors.white,
                    width: Get.width,
                    height: Get.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      scaffoldKey.currentState?.openDrawer(),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              homeController.photoUser.value),
                                          radius: 25,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -5,
                                        right: -5,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            Images_Icon.pencil,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ///////////////////////////////////////// pop
                                PopupMenuButton<int>(
                                  offset: Offset(0, 35),
                                  onSelected: (int value) {
                                    if (value == 1) {
                                      Get.updateLocale(Locale('ar'));
                                      Get.forceAppUpdate();
                                    } else if (value == 2) {
                                      Get.updateLocale(Locale('en'));
                                      Get.forceAppUpdate();
                                    } else if (value == 3) {
                                      Get.updateLocale(Locale('fr'));
                                      Get.forceAppUpdate();
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem<int>(
                                      value: 1,
                                      child: Text(
                                        "Arabic".tr,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Fontsized.fontsMidume,
                                            color: Colors.black),
                                      ),
                                    ),
                                    PopupMenuItem<int>(
                                      value: 2,
                                      child: Text(
                                        "English".tr,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Fontsized.fontsMidume,
                                            color: Colors.black),
                                      ),
                                    ),
                                    PopupMenuItem<int>(
                                      value: 3,
                                      child: Text(
                                        "French".tr,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Fontsized.fontsMidume,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                  child: Row(
                                    children: [
                                      Text(
                                        "translation".tr,
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Fontsized.fontsMidume,
                                            color: Colors.black),
                                      ),
                                      SizedBox(width: 3),
                                      SvgPicture.asset(Images_Icon.translation),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            /////////////////////////////////////// page view
                            Obx(() => SizedBox(
                                  width: Get.width,
                                  height: 180,
                                  child: PageView.builder(
                                    itemCount:
                                        homeController.image_PageViwe.length,
                                    controller: homeController.pageController,
                                    physics:
                                        NeverScrollableScrollPhysics(),
                                    onPageChanged: (value) {
                                      homeController.currentIndex.value = value;
                                    },
                                    itemBuilder: (context, index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        elevation: 3,
                                        child: Container(
                                          width: Get.width,
                                          height: 170,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: AssetImage(homeController
                                                  .image_PageViwe[index]),
                                              opacity: 0.5,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homeController
                                                    .TextOne[index].tr,
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                    fontSize: Fontsized
                                                        .DisplayMidume),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                homeController
                                                    .TextTow[index].tr,
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontSize: Fontsized
                                                        .DisplayMidume),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),

                            //////////////////////////////////// move desing
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                homeController.image_PageViwe.length,
                                (index) => Obx(
                                  () => Container(
                                    width: 12,
                                    height: 12,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                      color:
                                          homeController.currentIndex.value ==
                                                  index
                                              ? Colors.black
                                              : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /////////////////////////////////////:: text card service
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'All services'.tr,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: Fontsized.BodyMidume),
                                  ),
                                ],
                              ),
                            ),
                            ///////////////////////////////////////// list view
                            Obx(() => homeController.isLoadingService.value
                                ? SizedBox(
                                    height: Get.height / 3,
                                    child: SpinKitCircle(
                                      color: Colors.black,
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: homeController.AllService.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: Get.width,
                                        height: 250,
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Colors.white,
                                          elevation: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20)),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              Images_Icon
                                                                  .background),
                                                          fit: BoxFit.fill)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      homeController
                                                              .AllService[index]
                                                          ["Title"],
                                                      style: GoogleFonts.inter(
                                                          fontSize: Fontsized
                                                              .fontsMidume,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      homeController
                                                              .AllService[index]
                                                          ["Description"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                          fontSize: Fontsized
                                                              .DisplaySmall,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black),
                                                    ),
                                                   Obx(
                                                    ()=> Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            homeController.makePhoneCall("+21220058512");
                                                          },
                                                          icon:
                                                              SvgPicture.asset(
                                                            Images_Icon.Calling,
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                        ),
                                                        Text(
                                                          'calling'.tr,
                                                          style: GoogleFonts.inter(
                                                              fontSize: Fontsized
                                                                  .DisplayMidume,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              if(homeController.AddIdUser.contains(firebaseService.currentId)){
                                                                homeController.AddIdUser.remove(firebaseService.currentId);
                                                                print(homeController.AddIdUser);
                                                              }else{
                                                                homeController.AddIdUser.add(firebaseService.currentId);
                                                                print(homeController.AddIdUser);
                                                              }
                                                              print(homeController.AllService[index].id);
                                                            },
                                                            icon: SvgPicture.asset(
                                                              Images_Icon.heart_fille,
                                                              width: 20,
                                                              height: 20,
                                                            )),
                                                        Text(
                                                          "${homeController.likes.value}",
                                                          style: GoogleFonts.inter(
                                                              fontSize: Fontsized.DisplayMidume,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    )
                                                   )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                                  SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
