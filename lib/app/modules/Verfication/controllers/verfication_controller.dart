import 'package:abdollah_srevice/app/modules/Verfication/pages/V_tow.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerficationController extends GetxController {
  TextEditingController email = TextEditingController();
  RxBool obscureText = true.obs;
  RxBool obscureTextConfirm = true.obs;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isLoading = false.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureTextConfirm.value = !obscureTextConfirm.value;
  }

  Future<void> sendOtpToEmail() async {
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email.text);
      Get.snackbar("Success", "OTP sent to your email!");
      Get.to(()=>Verfication_tow());
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePassword() async {
    if (password.text != confirmPassword.text) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }
    isLoading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(password.text);
        Get.snackbar("Success", "Password updated successfully!");
      } else {
        Get.snackbar("Error", "User not authenticated.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update password: ${e.toString()}");
    } finally {
      isLoading.value = false;
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
