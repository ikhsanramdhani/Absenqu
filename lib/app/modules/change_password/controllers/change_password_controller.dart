import 'dart:math';

import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class ChangePasswordController extends GetxController {
  RxBool isLoad = false.obs;
  TextEditingController currPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confNewPassCtrl = TextEditingController();

  RxBool currObs = true.obs;
  RxBool newObs = true.obs;
  RxBool confObs = true.obs;

  void changePassword() async {
    if (currPassCtrl.text.isNotEmpty &&
        newPassCtrl.text.isNotEmpty &&
        confNewPassCtrl.text.isNotEmpty) {
      if (currPassCtrl.text == newPassCtrl.text) {
        CustomSnackbar.errorSnackbar(
            "Error", "New password cannot same with current password");
      } else if (newPassCtrl.text == "student") {
        CustomSnackbar.errorSnackbar(
            "Error", "New password cannot same with first default password");
      } else if (newPassCtrl.text == confNewPassCtrl.text) {
        isLoad.value = true;
        try {
          String email = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: email, password: currPassCtrl.text);
          await auth.currentUser!.updatePassword(newPassCtrl.text);
          Get.back();
          CustomSnackbar.successSnackbar("Success", "Success change password");
        } catch (e) {
          CustomSnackbar.errorSnackbar("Error", "Error : ${e.toString()}");
        } finally {
          isLoad.value = false;
        }
      } else {
        CustomSnackbar.errorSnackbar("Error", "Confirm password not same");
      }
    } else {
      CustomSnackbar.errorSnackbar("Error", "You must input all form");
    }
  }
}
