import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../consts/firebase_const.dart';
import 'auth_services.dart';

class ProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  AuthControllers authControllers = Get.put(AuthControllers());
  var profileImagePath = ''.obs;
  var profileImageUrl = '';
  var isLoading = false.obs;

  changeProfileImage(BuildContext context) async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
      }
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  uploadProfileImage({required String name}) async {
    try {
      var filename = basename(profileImagePath.value);
      var destination = 'profile_images/${currentUser!.uid}';
      var reference = FirebaseStorage.instance.ref().child(destination);
      await reference.putFile(File(profileImagePath.value));
      profileImageUrl = await reference.getDownloadURL();
      updateProfile(name: name, uri: profileImageUrl);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  updateProfile({required String name, required uri}) async {
    try {
      var store = firestore.collection(userCollection).doc(currentUser!.uid);
      await store.set({
        'photoUrl': uri,
        'name': name,
      }, SetOptions(merge: true));
      isLoading(false);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void clearProfileImage() {
    profileImagePath.value = '';
  }
}
