import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:abdollah_srevice/app/config/Size/fontsized.dart';
import 'package:abdollah_srevice/app/modules/Verfication/pages/v_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Verfication_tow extends StatefulWidget {
  const Verfication_tow({super.key});

  @override
  State<Verfication_tow> createState() => _Verfication_towState();
}

class _Verfication_towState extends State<Verfication_tow> {
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
                    'Verification code'.tr,
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
                'please enter the verification code that has been sent to'.tr,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: Fontsized.fontsLarge),
              ),
            ),
            /////////////////////////////////////////////////////// otp
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  OtpForm(),
                  /////////////////////////////////////////////////////////// button
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
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
///
const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //////////////////////////// one 
              SizedBox(
                height: 60,
                width: 60,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Color(0xFFFF7643)))),
                ),
              ),
              /////////////////////////////// tow
              SizedBox(
                 height: 60,
                width: 60,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Color(0xFFFF7643)))),
                ),
              ),
              /////////////////////////////// three
              SizedBox(
                 height: 60,
                width: 60,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Color(0xFFFF7643)))),
                ),
              ),
              ////////////////////////////////// fore
              SizedBox(
               height: 60,
                width: 60,
                child: TextFormField(
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Color(0xFF757575)),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Color(0xFFFF7643)))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
