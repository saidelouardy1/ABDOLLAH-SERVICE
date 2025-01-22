import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  RxBool obscureText = true.obs;
  RxBool obscureTextConferme = true.obs;
  TextEditingController full_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController ConfermPassword = TextEditingController();
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
  ///
  Future<void> signUp() async {
    isLoading.value = true;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      final token = await credential.user?.getIdToken();
      await FirebaseFirestore.instance.collection('users').add({
        "image":
            "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "fullName": full_name.text.trim(),
        "email": email.text.trim(),
        "token": token,
      }).then((value) {
        Get.dialog(
          AlertDialog(
            title: Text(
              'Success'.tr,
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
            content: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'User successfully registered!'.tr,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          Get.back();
          Get.back();
        });
        isLoading.value = false;
      }).catchError((error) {
        print("Failed to add user: $error");
        isLoading.value = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("info".tr, 'snackbar_password_weak'.tr,
            duration: Duration(seconds: 3));
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("info".tr, 'snackbar_email_in_use'.tr,
            duration: Duration(seconds: 3));
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  ///////////////////////////////////////////////////////////////////////// sing in
  ///
  Future<void> signIn() async {
    isLoading.value = true;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String errorMessag = '';
      if (e.code == 'user-not-found') {
        errorMessag = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessag = "Wrong password provided for that user.";
      } else {
        errorMessag =
            "The password or email provided for this user is incorrect".tr;
        print(e.message);
      }
      Get.dialog(
        AlertDialog(
          title: Text('info'.tr),
          content: Text(errorMessag),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

////////////////////////////////////////////// sing with google
  ///
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Google sign-in canceled');
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Extract user data
        final String? name = user.displayName;
        final String? photoURL = user.photoURL;
        final String? email = user.email;
        final String uid = user.uid;
        final DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(uid);
        await userRef.set({
          'fullName': name,
          'image': photoURL,
          'email': email,
          'uid': uid,
          'token': googleAuth.accessToken,
        }, SetOptions(merge: true));
        Get.offNamed(Routes.HOME);
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /////////////////////////////////////////////// sing with facebook
  ///
  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        final User? user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'uid': user.uid,
            'fullName': user.displayName ?? '',
            'email': user.email ?? '',
            'image': user.photoURL ?? '',
            'token': accessToken.tokenString,
          }, SetOptions(merge: true));
          Get.offNamed(Routes.HOME);
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        print("Facebook sign-in was cancelled.");
      } else {
        print("Facebook sign-in failed. Please try again.");
      }
      isLoading.value = false;
    } catch (e) {
      print("An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
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
