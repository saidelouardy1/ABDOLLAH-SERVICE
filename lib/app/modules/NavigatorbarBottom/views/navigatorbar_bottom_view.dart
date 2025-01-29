import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/modules/Location/views/location_view.dart';
import 'package:abdollah_srevice/app/modules/chat/views/chat_view.dart';
import 'package:abdollah_srevice/app/modules/discreiption/views/discreiption_view.dart';
import 'package:abdollah_srevice/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/navigatorbar_bottom_controller.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class NavigatorbarBottomView extends GetView<NavigatorbarBottomController> {
  const NavigatorbarBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorBarController = Get.find<NavigatorbarBottomController>();

    return Scaffold(
      body: Obx(() {
        switch (navigatorBarController.selectedIndex.value) {
          case 0:
            return HomeView();
          case 1:
            return ChatView();
          case 2:
            return DiscreiptionView();
          case 3:
            return LocationView();
          default:
            return HomeView(); 
        }
      }),
      bottomNavigationBar: Obx(
        () => FlashyTabBar(
          backgroundColor: Colors.white,
          selectedIndex: navigatorBarController.selectedIndex.value,
          onItemSelected: navigatorBarController.changeTab,
          items: [
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                Images_Icon.home,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              title: Text(
                'Home'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: Fontsized.fontsSmall,
                  color: Colors.black
                ),),
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                Images_Icon.chat,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              title: Text(
                'Chat'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: Fontsized.fontsSmall,
                  color: Colors.black
                ),),
            ),
            FlashyTabBarItem(
              icon:  SvgPicture.asset(
                Images_Icon.discription,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              title: Text(
                'Description'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: Fontsized.fontsSmall,
                  color: Colors.black
                ),
                ),
            ),
            FlashyTabBarItem(
              icon:  SvgPicture.asset(
                Images_Icon.location,
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              title: Text(
                'Location'.tr,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: Fontsized.fontsSmall,
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
