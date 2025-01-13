import 'package:abdollah_srevice/app/modules/Authentication/views/authentication_view.dart';
import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body:  Center(
        child: TextButton(
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Get.offNamed(Routes.AUTHENTICATION);
          },
          child: Text('HomeView is working',
          style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}
