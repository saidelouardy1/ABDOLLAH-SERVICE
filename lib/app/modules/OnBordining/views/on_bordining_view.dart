import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/modules/Authentication/bindings/authentication_binding.dart';
import 'package:abdollah_srevice/app/modules/Authentication/views/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/on_bordining_controller.dart';

class OnBordiningView extends GetView<OnBordiningController> {
  const OnBordiningView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
                width: Get.width,
                height: Get.height,
                padding: EdgeInsets.only( bottom: 40, left: 45, right: 45),
                decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images_Icon.onbordining),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color(0xFF0D6EFD),
                  Colors.transparent,
                ])),
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Text(
              "onbordingOne".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: Fontsized.SizedLarge,
              ),
            ),
            IntrinsicHeight(
              child: Container(
                width: Get.width/2,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  minWidth: Get.width,
                  onPressed: () {
                    Get.to(() => AuthenticationView(),
                        binding: AuthenticationBinding());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'onbordingTow'.tr,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: Fontsized.BodyMidume,
                        ),
                      ),
                   Get.locale?.languageCode == "ar"
                  ?
                    SvgPicture.asset(
                          Images_Icon.doubleNextLeft,
                        width: 30,
                        height: 30,
                      )
                      :
                       SvgPicture.asset(
                          Images_Icon.doubleNext,
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
                ),
              ),
        ));
  }
}
