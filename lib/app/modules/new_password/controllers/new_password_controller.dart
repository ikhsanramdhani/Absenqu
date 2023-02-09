import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class NewPasswordController extends GetxController {
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confPassCtrl = TextEditingController();
  String email = auth.currentUser!.email!;

  RxBool isLoad = false.obs;
  RxBool passObs = true.obs;
  RxBool confPassObs = true.obs;

  void newPassword() async {
    if (newPassCtrl.text.isNotEmpty && confPassCtrl.text.isNotEmpty) {
      isLoad.value = true;
      if (newPassCtrl.text == "student") {
        CustomSnackbar.errorSnackbar("Error", "You must change password");
      } else if (newPassCtrl.text == confPassCtrl.text) {
        try {
          await auth.currentUser!.updatePassword(newPassCtrl.text);
          await auth.signOut();

          CustomSnackbar.successSnackbar(
              "Success", "You're password has been changed");
          await auth.signInWithEmailAndPassword(
              email: email, password: newPassCtrl.text);
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (err) {
          if (err.code == "weak-password") {
            CustomSnackbar.errorSnackbar("Error", "Password too short");
          }
        } catch (e) {
          print(e);
        } finally {
          isLoad.value = false;
        }
      } else {
        isLoad.value = false;
        CustomSnackbar.errorSnackbar('Error', 'Password doesnt match');
      }
    } else {
      CustomSnackbar.errorSnackbar('Error', 'You must fill all form');
    }
  }
}
