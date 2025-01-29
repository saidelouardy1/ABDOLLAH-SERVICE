import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class VerficationController extends GetxController {
  TextEditingController email = TextEditingController();
  RxBool obscureText = true.obs;
  RxBool obscureTextConfirm = true.obs;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureTextConfirm.value = !obscureTextConfirm.value;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset link sent! Check your email.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
