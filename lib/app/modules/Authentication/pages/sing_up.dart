import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/config/Theme/theme.dart';
import 'package:abdollah_srevice/app/modules/Authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingOutState();
}

class _SingOutState extends State<SingUp> {
  AuthenticationController authenticationController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.white_4,
      body:Obx(()=> ModalProgressHUD(
        inAsyncCall: authenticationController.isLoading.value,
        progressIndicator: SpinKitCircle(
          color: Colors.orange,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.only(top:40, left: 15, right: 15),
            decoration: BoxDecoration(color: ColorApp.white_4),
            child: ListView(
              children: [
                Transform.translate(
                  offset: Offset(-10, 0),
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
                        'Sign Up'.tr,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: Fontsized.fontsLarge),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ///////////////////////////////// fullname
                      textFromefild("Nom Complet", "${"ex".tr} John Doe", false,
                          (value) {
                        if (value!.isEmpty) {
                          return "name_empty".tr;
                        }
                        return null;
                      }, authenticationController.full_name),
                      ///////////////////////////////// email
                      textFromefild(
                          "Email", " ${"ex".tr} Johndoe@example.com", false,
                          (value) {
                        if (value!.isEmpty) {
                          return "email_empty".tr;
                        }else if(!authenticationController.emailValid.hasMatch(value)){
                          return "invalid_email".tr;
                        }
                        return null;
                      }, authenticationController.email),
                      ///////////////////////////////////////////// password
                      Obx(
                        () => textFromefild(
                          "Mot de passe",
                          "••••••••",
                          authenticationController.obscureText.value,
                          (value) {
                            if (value!.isEmpty) {
                              return "password_empty".tr;
                            }
                            return null;
                          },
                          authenticationController.password,
                          iconSvg: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                authenticationController.toggle();
                                print(authenticationController.obscureText.value);
                              },
                              icon: SvgPicture.asset(
                                  authenticationController.obscureText.value
                                      ? Images_Icon.eayeClose
                                      : Images_Icon.eayOpen)),
                        ),
                      ),
                      ///////////////////////////////// confirm password
                      Obx(
                        () => textFromefild(
                          "Confirmer le Mot de passe",
                          "••••••••",
                          authenticationController.obscureTextConferme.value,
                          (value) {
                            if (value!.isEmpty) {
                              return "password_empty".tr;
                            }
                            if (value != authenticationController.password.text) {
                              return "passwords_mismatch".tr;
                            }
                            return null;
                          },
                          authenticationController.ConfermPassword,
                          iconSvg: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                authenticationController.toggleConferme();
                              },
                              icon: SvgPicture.asset(authenticationController
                                      .obscureTextConferme.value
                                  ? Images_Icon.eayeClose
                                  : Images_Icon.eayOpen)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),
                ///////////////////////////////////////// sign up button
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: MaterialButton(
                    minWidth: Get.width,
                    splashColor: Colors.transparent,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                         authenticationController.signUp();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Sign Up".tr,
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
        ),
      ),)
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
              border:  OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp.grey_1),
                  borderRadius: BorderRadius.circular(20)),
                  ),
              validator: Callback,
        ),
      ],
    );
  }
}
