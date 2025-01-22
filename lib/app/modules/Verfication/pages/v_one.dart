import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/config/Theme/theme.dart';
import 'package:abdollah_srevice/app/modules/Verfication/controllers/verfication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Verfication_One extends StatefulWidget {
  const Verfication_One({super.key});

  @override
  State<Verfication_One> createState() => _Verfication_OneState();
}

class _Verfication_OneState extends State<Verfication_One> {
  VerficationController verficationController = Get.find();
  GlobalKey<FormState> fromKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: EdgeInsets.only(top: 40, left: 15, right: 15),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: SvgPicture.asset(
                      Get.locale?.languageCode == "ar"
                          ? Images_Icon.right
                          : Images_Icon.back,
                      width: 25,
                      height: 25,
                    )),
                Text(
                  'Resset password'.tr,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: Fontsized.fontsLarge),
                ),
              ],
            ),
          ),
          ////////////////////
          Expanded(
            flex: 1,
            child: Text(
              'Please enter your email address to request a password reset'.tr,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400, fontSize: Fontsized.fontsLarge),
            ),
          ),
          ////////////////////////////////// input email
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Form(
                  key: fromKey,
                  child: textFromefild(
                            "Email", " ${"ex".tr} Johndoe@example.com", false,
                            (value) {
                          if (value!.isEmpty) {
                            return "email_empty".tr;
                          }else if(!GetUtils.isEmail(value)){
                            return "invalid_email".tr;
                          }
                          return null;
                        }, verficationController.email),
                ),
                SizedBox(height: 30),
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: MaterialButton(
                    minWidth: Get.width,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      if(fromKey.currentState!.validate()){
                        verficationController.sendOtpToEmail();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Next".tr,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: Fontsized.BodyLarge),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /////////////////////////////////// button
          ///
        ],
      ),
    );
  }

  Widget textFromefild(String label, String hint, bool iconPassword,
      FormFieldValidator<String>? Callback, TextEditingController controller,
      {Widget? iconSvg}) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              label.tr,
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          obscureText: iconPassword,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: iconSvg,
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: ColorApp.grey,
                  fontSize: Fontsized.fontsMidume),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp.grey_1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp.grey_1),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp.grey_1),
                  borderRadius: BorderRadius.circular(20))),
          validator: Callback,
        ),
      ],
    );
  }
}
