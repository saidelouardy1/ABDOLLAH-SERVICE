import 'package:abdollah_srevice/app/modules/home/controllers/home_controller.dart';
import 'package:abdollah_srevice/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

HomeController homeController = Get.find<HomeController>();
class FirebaseService {
  String currentId = FirebaseAuth.instance.currentUser!.uid;
//////////////////////////////////////////////// fetch data user
  Future<void> fetchDataUser() async {
    homeController.isLoading.value = true;
    try {
      final uidUser = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uidUser)
          .get();
      if (userQuery.docs.isNotEmpty) {
        var userDoc = userQuery.docs.first;
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        homeController.userName.value = userData['fullName'];
        homeController.userEmail.value = userData['email'];
        homeController.photoUser.value = userData['image'];
        print(userData);
      } else {
        print('No user is currently logged in');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      homeController.isLoading.value = false;
    }
  }

//////////////////////////// fetch data  service
  Future<void> fetchAllservice() async {
    homeController.isLoadingService.value = true;
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("AllService").get();
      if (querySnapshot.docs.isNotEmpty) {
        homeController.AllService.clear();
        homeController.AllService.addAll(querySnapshot.docs);
        print(homeController.AllService);
      }
    } catch (e) {
      print("Error fetching services: $e");
      homeController.isLoadingService.value = false;
    } finally {
      homeController.isLoadingService.value = false;
    }
  }

/////////////////// Log out
  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        if (user.providerData
            .any((element) => element.providerId == 'google.com')) {
          GoogleSignIn googleSignIn = GoogleSignIn();
          await googleSignIn.signOut();
          await FirebaseAuth.instance.signOut();
        } else if (user.providerData
            .any((element) => element.providerId == 'facebook.com')) {
          final facebookLogin = FacebookAuth.instance;
          await facebookLogin.logOut();
          await FirebaseAuth.instance.signOut();
        } else if (user.providerData
            .any((element) => element.providerId == 'password')) {
          await FirebaseAuth.instance.signOut();
        } else if (user.providerData
            .any((element) => element.providerId == 'apple.com')) {
          await FirebaseAuth.instance.signOut();
        }
        Get.offAllNamed(Routes.AUTHENTICATION);
      } catch (e) {
        print('Error signing out: $e');
      }
    }
  }
}
