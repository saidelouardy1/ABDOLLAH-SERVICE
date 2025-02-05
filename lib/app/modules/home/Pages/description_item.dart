import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DescriptionItem extends GetView<HomeController> {
  const DescriptionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Get.back();
          }, 
          icon: SvgPicture.asset(
            Images_Icon.back,
            width: 24,
            height: 24,
          )
          ),
        title: Text(
          'ffff',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: Fontsized.BodyMidume
          ),
        ),
        centerTitle:true,
      ),
      body: Card(
        color: Colors.white,
        elevation: 30,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 30),
                alignment: Alignment.topCenter,
                child: Text(
                  'data',
                  style: GoogleFonts.inter(
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}