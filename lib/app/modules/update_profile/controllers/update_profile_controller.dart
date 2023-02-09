import 'dart:io';

import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:image_picker/image_picker.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
s.FirebaseStorage storage = s.FirebaseStorage.instance;

class UpdateProfileController extends GetxController {
  RxBool isLoad = false.obs;
  TextEditingController nimCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> updateProfile(String uid) async {
    if (nimCtrl.text.isNotEmpty &&
        nameCtrl.text.isNotEmpty &&
        emailCtrl.text.isNotEmpty) {
      isLoad.value = true;
      try {
        var dataUpdate = {"name": nameCtrl.text};
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref("$uid/profile.$ext").putFile(file);
          String photoUrl =
              await storage.ref("$uid/profile.$ext").getDownloadURL();
          dataUpdate.addAll({"photoUrl": photoUrl});
        }
        await firestore.collection('student').doc(uid).update(dataUpdate);
        image = null;
        Get.back();
        CustomSnackbar.successSnackbar("Success", "Success update profile");
      } catch (e) {
        CustomSnackbar.errorSnackbar("Error", "Error : ${e.toString()}");
      } finally {
        isLoad.value = false;
      }
    } else {
      CustomSnackbar.errorSnackbar("Error", "You must input all form");
    }
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void deleteImage(String uid) async {
    try {
      await firestore
          .collection('student')
          .doc(uid)
          .update({"photoUrl": FieldValue.delete()});
      Get.back();
      CustomSnackbar.successSnackbar("Success", "Success delete avatar");
    } catch (e) {
      CustomSnackbar.errorSnackbar("Error", "Error : ${e.toString()}");
    } finally {
      update();
    }
  }
}
