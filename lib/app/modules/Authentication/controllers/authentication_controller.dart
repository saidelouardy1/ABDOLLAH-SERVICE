import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  RxBool obscureText = true.obs;
  RxBool obscureTextConferme = true.obs;
  TextEditingController full_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController ConfermPassword = TextEditingController();
  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RxBool isLoading = false.obs;

  ////////////////////////////////////
  ///
  void toggle() {
    obscureText.value = !obscureText.value;
  }

  void toggleConferme() {
    obscureTextConferme.value = !obscureTextConferme.value;
  }

////////////////////////////////////////////////////////////////////// sign up

  Future<void> signUp() async {
    isLoading.value = true;
    try {
      // Create user with Firebase Authentication
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final token = await credential.user?.getIdToken();

      await FirebaseFirestore.instance.collection('users').add({
        "image":
            "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
        "fullName": full_name.text.trim(),
        "email": email.text.trim(),
        "token": token,
      }).then((value) {
        Get.dialog(
          AlertDialog(
            title: Text('Success'),
            content: Text('User successfully registered!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back(); 
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        isLoading.value = false;
      }).catchError((error) {
        print("Failed to add user: $error");
        isLoading.value = false;
        Get.snackbar("Error", "Failed to add user: $error".tr,
            duration: Duration(seconds: 3));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("info", 'snackbar_password_weak'.tr,
            duration: Duration(seconds: 3));
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("info", 'snackbar_email_in_use'.tr,
            duration: Duration(seconds: 3));
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  ///////////////////////////////////// sing in
  ///
  Future<void> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('snackbar_user_not_found'.tr);
      } else if (e.code == 'wrong-password') {
        print('snackbar_wrong_password'.tr);
      }
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
