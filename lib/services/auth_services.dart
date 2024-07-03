import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ping_me/services/profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/firebase_const.dart';
import '../pages/splash_screeen/splash_screen.dart';

class AuthControllers extends GetxController {
  var isLoading = false.obs;

  Future<UserCredential?> loginMethod({
    required email,
    required password,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (exp) {
      VxToast.show(Get.context!, msg: exp.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signUpMethod({
    required email,
    required password,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (exp) {
      VxToast.show(Get.context!, msg: exp.toString());
    }
    return userCredential;
  }

  storeUserData(
      {required uid,
      required email,
      required displayName,
      required phoneNumber,
      required photoURL,
      required countryCode}) async {
    DocumentReference store = firestore.collection(userCollection).doc(uid);
    store.set({
      'uid': uid,
      'email': email,
      'name': displayName,
      'photoUrl': photoURL,
      'createdAt': Timestamp.now(),
      'status': 'Online',
    });
  }

  signOut() async {
    try {
      currentUser = null;
      await auth.signOut();
      ProfileController profileController = Get.find();
      profileController.clearProfileImage();
      Get.off(() => const SplashScreen());
    } on FirebaseAuthException catch (exp) {
      VxToast.show(Get.context!, msg: exp.toString());
    }
  }

  currentUserUid() {
    return auth.currentUser?.uid;
  }
}
