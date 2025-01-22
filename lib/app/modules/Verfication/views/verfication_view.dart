import 'package:abdollah_srevice/app/config/Theme/theme.dart';
import 'package:abdollah_srevice/app/modules/Verfication/pages/v_one.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verfication_controller.dart';

class VerficationView extends GetView<VerficationController> {
  const VerficationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.white_4,
      body: Verfication_One()
    );
  }
}
