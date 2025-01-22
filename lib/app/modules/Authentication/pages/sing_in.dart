import 'dart:io';
import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/config/Theme/theme.dart';
import 'package:abdollah_srevice/app/modules/Authentication/controllers/authentication_controller.dart';
import 'package:abdollah_srevice/app/modules/Authentication/pages/sing_up.dart';
import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

 class SingIn extends StatefulWidget {
  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  AuthenticationController authenticationController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Obx(()=>ModalProgressHUD(
      inAsyncCall: authenticationController.isLoading.value,
       progressIndicator: SpinKitCircle(
          color: Colors.orange,
        ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.only(top: 40, left: 15, right: 15),
          decoration: BoxDecoration(color: ColorApp.white_4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    'Sign In'.tr,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: Fontsized.fontsLarge),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    ///////////////////////////////// email
                    textFromefild(
                      "Email", 
                      "${"ex".tr} John Doe",
                       false , 
                       (value) {
                        if (value!.isEmpty) {
                          return "email_empty".tr;
                        }else if(!GetUtils.isEmail(value)){
                          return "invalid_email".tr;
                        }
                        return null;
                      }, authenticationController.email,
                    ),
                    ///////////////////////////////////////////// password
                    Obx(
                      () => textFromefild(
                        "Mot de passe",
                        "••••••••",
                        authenticationController.obscureText.value,
                        iconSvg: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              authenticationController.toggle();
                              print(authenticationController.obscureText.value);
                            },
                            icon: SvgPicture.asset(
                              authenticationController.obscureText.value
                              ?Images_Icon.eayeClose
                              :Images_Icon.eayOpen
                            )
                            ),
                            (value) {
                          if (value!.isEmpty) {
                            return "password_empty".tr;
                          }
                          return null;
                        }, authenticationController.password,
                      ),
      
                    ),
                    //////////////////////////////////////////////////////////// remember
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (Value) {},
                              checkColor: Colors.black,
                              activeColor: Colors.amber,
                            ),
                            Text(
                              "Remember Me".tr,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: Fontsized.BodySmall,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.VERFICATION);
                          },
                          child: Text(
                            "Forgot Password".tr,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: Fontsized.BodySmall,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ///////////////////////////////////////// button sing in
              Card(
                elevation: 4,
                color: Colors.white,
                child: MaterialButton(
                  minWidth: Get.width,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      authenticationController.signIn();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Sign In".tr,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: Fontsized.BodyLarge),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account".tr,
                      style: GoogleFonts.podkova(
                          fontWeight: FontWeight.w500,
                          fontSize: Fontsized.fontsSmall,
                          color: Colors.black)),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SingUp());
                    },
                    child: Text('Create Account'.tr,
                        style: GoogleFonts.podkova(
                            fontWeight: FontWeight.w900,
                            fontSize: Fontsized.fontsSmall,
                            color: Colors.black,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              ///////////////////////////////////////////// social medya
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //////////////////////////// chrome
                  IconButton(
                    onPressed: () {
                      authenticationController.signInWithGoogle();
                    },
                    highlightColor: Colors.transparent,
                    icon: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          child: SvgPicture.asset(Images_Icon.chrome)),
                    ),
                  ),
                  //////////////////////////////// facebook
                  IconButton(
                    onPressed: () {
                      authenticationController.signInWithFacebook();
                    },
                    highlightColor: Colors.transparent,
                    icon: Card(
                      elevation: 5,
                      color: ColorApp.blue_1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          child: SvgPicture.asset(Images_Icon.facebook)),
                    ),
                  ),
                  //////////////////////// apple
                  if (Platform.isIOS)
                       IconButton(
                          onPressed: () {
                            print("apple");
                          },
                          highlightColor: Colors.transparent,
                          icon: Card(
                            elevation: 5,
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                child: SvgPicture.asset(Images_Icon.apple)),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget textFromefild(String label, String hint, bool iconPassword, FormFieldValidator<String>? Callback ,TextEditingController controller ,{Widget? iconSvg}) {
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
          controller: controller ,
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
              border:  OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp.grey_1),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp.grey_1),
                  borderRadius: BorderRadius.circular(20))
                ),
            validator: Callback,
        ),
      ],
    );
  }
}
