import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
   SplashScreenView({super.key});
  SplashScreenController splashScreenController = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images_Icon.background),
              fit: BoxFit.fill,
              opacity: 0.3
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
              const Color(0xFF0D6EFD),
              Colors.transparent,
            ])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width/2,
                height: Get.height/2.8,
                child: Image.asset(Images_Icon.log)
              ),
              Text(
                "name app".tr,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: Fontsized.fontsLarge
                ),
              ),
              SizedBox(
                height: 15,
              ),
             Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [
                SpinKitWaveSpinner(
                  color: Colors.white,
                  waveColor: Colors.blueAccent,
                  size: 70,
                ),
                Positioned(
                  child: Text(
                    "${(splashScreenController.progress.value * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Fontsized.fontsSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }),
            ],
          ),
        ),
      )
    );
  }
}
