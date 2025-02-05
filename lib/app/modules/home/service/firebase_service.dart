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
////

  Future<void> fetchAllservice() async {
    homeController.isLoadingService.value = true;
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("AllService").get();
      if (querySnapshot.docs.isNotEmpty) {
        homeController.AllService.clear();
        for (var doc in querySnapshot.docs) {
          homeController.AllService.add(doc);
          String currentId = FirebaseAuth.instance.currentUser!.uid;
          List<dynamic> likes = doc['PersonWhoDoLikes'] ?? [];
        }
      }
    } catch (e) {
      print("Error fetching services: $e");
    } finally {
      homeController.isLoadingService.value = false;
    }
  }

  Future<void> toggleLikeAndIncrementWonder(String serviceId) async {
    final serviceRef = FirebaseFirestore.instance.collection("AllService").doc(serviceId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot serviceDoc = await transaction.get(serviceRef);
      if (serviceDoc.exists) {
        List<dynamic> likes = serviceDoc['PersonWhoDoLikes'] ?? [];
        int currentWonderCount = serviceDoc['wonder'] ?? 0;
        if (likes.contains(currentId)) {
          transaction.update(serviceRef, {
            'PersonWhoDoLikes': FieldValue.arrayRemove([currentId]),
            'wonder': currentWonderCount > 0 ? currentWonderCount - 1 : 0,
          });
        } else {
          transaction.update(serviceRef, {
            'PersonWhoDoLikes': FieldValue.arrayUnion([currentId]),
            'wonder': currentWonderCount + 1,
          });
        }
      }
    });
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
