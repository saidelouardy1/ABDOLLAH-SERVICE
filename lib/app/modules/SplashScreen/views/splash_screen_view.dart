import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/config/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.background),
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
              child: Image.asset(Assets.log)
            ),
            Text(
              "name app".tr,
              style: GoogleFonts.puppiesPlay(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: Fontsized.fontsLarge
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SpinKitWaveSpinner(
              color: Colors.blue.shade700,
              waveColor: Colors.blue.shade700,
              size: 70,
            )
          ],
        ),
      )
    );
  }
}
