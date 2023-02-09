import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class ForgotPasswordController extends GetxController {
  RxBool isLoad = false.obs;
  TextEditingController emailCtrl = TextEditingController();

  Future<void> forgotPassword() async {
    if (emailCtrl.text.isNotEmpty) {
      isLoad.value = true;

      try {
        await auth.sendPasswordResetEmail(email: emailCtrl.text);
        CustomSnackbar.successSnackbar(
            "Success", "Success send verification to ${emailCtrl.text}");
      } on FirebaseAuthException catch (err) {
        if (err.code == "invalid-email") {
          CustomSnackbar.errorSnackbar("Error", "Please input valid email");
        } else if (err.code == "user-not-found") {
          CustomSnackbar.errorSnackbar("Error", "User not found");
        } else {
          CustomSnackbar.errorSnackbar("Error", "Error because : ${err.code}");
        }
      } catch (e) {
        print(e);
      } finally {
        emailCtrl.clear();
        isLoad.value = false;
      }
    } else {
      CustomSnackbar.errorSnackbar("Error", "You must input email");
    }
  }
}
