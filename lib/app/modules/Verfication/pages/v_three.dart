import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/config/Theme/theme.dart';
import 'package:abdollah_srevice/app/modules/Verfication/controllers/verfication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Verfication_three extends StatefulWidget {
  const Verfication_three({super.key});

  @override
  State<Verfication_three> createState() => _Verfication_threeState();
}

class _Verfication_threeState extends State<Verfication_three> {
  VerficationController verficationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    'Reinitialiser le passe'.tr,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: Fontsized.fontsLarge),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Please enter a new password'.tr,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: Fontsized.fontsLarge),
              ),
            ),
            Expanded(
              flex: 5,
              child: Form(
                child: Column(
                  children: [
                    ///////////////////////////////////////////// password
                    Obx(
                      () => textFromefild(
                        "Mot de passe",
                        "••••••••",
                        verficationController.obscureText.value,
                        (value) {
                          if (value!.isEmpty) {
                            return "password_empty".tr;
                          }
                          return null;
                        },
                        verficationController.password,
                        iconSvg: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              verficationController.togglePasswordVisibility();
                              print(verficationController.obscureText.value);
                            },
                            icon: SvgPicture.asset(
                                verficationController.obscureText.value
                                    ? Images_Icon.eayeClose
                                    : Images_Icon.eayOpen)),
                      ),
                    ),
                    ///////////////////////////////// confirm password
                    Obx(
                      () => textFromefild(
                        "Confirmer le Mot de passe",
                        "••••••••",
                        verficationController.obscureText.value,
                        (value) {
                          if (value!.isEmpty) {
                            return "password_empty".tr;
                          }
                          if (value != verficationController.password.text) {
                            return "passwords_mismatch".tr;
                          }
                          return null;
                        },
                        verficationController.confirmPassword,
                        iconSvg: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              verficationController.toggleConfirmPasswordVisibility();
                            },
                            icon: SvgPicture.asset(
                                verficationController.obscureTextConfirm.value
                                    ? Images_Icon.eayeClose
                                    : Images_Icon.eayOpen)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      child: MaterialButton(
                        minWidth: Get.width,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          // if(fromKey.currentState!.validate()){
                          //   Get.to(()=>Verfication_tow());
                          // }
                          Get.to(() => Verfication_three());
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
            )
          ],
        ),
      ),
    );
  }

  Widget textFromefild(String label, String hint, bool IconPassword,
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
          controller: controller,
          obscureText: IconPassword,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: iconSvg,
            hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: ColorApp.grey,
                fontSize: Fontsized.fontsMidume),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorApp.grey_1, width: 1),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorApp.grey_1, width: 1),
                borderRadius: BorderRadius.circular(20)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorApp.grey_1),
                borderRadius: BorderRadius.circular(20)),
          ),
          validator: Callback,
        ),
      ],
    );
  }
}
