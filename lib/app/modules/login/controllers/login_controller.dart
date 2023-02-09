import 'package:absenqu/app/data/widgets/custom_dialog.dart';
import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class LoginController extends GetxController {
  RxBool isLoad = false.obs;
  RxBool obsecure = true.obs;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  Future<void> login() async {
    // jika email dan password tidak kosong, maka eksekusi code dibawah
    // Get.dialog(Loading());
    if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      isLoad.value = true;

      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailCtrl.text, password: passCtrl.text);
        print(userCredential);

        // jika input login tidak = null, maka eksekusi code dibawah
        if (userCredential.user != null) {
          // jika email sudah diverifikasi, maka eksekusi code dibawah
          if (userCredential.user!.emailVerified) {
            isLoad.value = false;
            await firestore
                .collection('student')
                .doc(auth.currentUser!.uid)
                .update({
              "active": "true",
            });
            // jika password masih sama dengan default, maka ke halaman password baru
            if (passCtrl.text == "student") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              // jika sudah diganti, langsung ke home
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            // jika email blm diverifikasi, beri alert untuk send link ulang
            CustomDialog.showPresenceAlert(
              title: "Email not yet verified",
              message: "Are you want to send email verification?",
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await userCredential.user!.sendEmailVerification();
                  emailCtrl.clear();
                  passCtrl.clear();
                  Get.back();
                  CustomSnackbar.successSnackbar(
                      "Success", "We've send email verification to your email");
                } catch (e) {
                  Get.back();
                  CustomSnackbar.errorSnackbar("Error",
                      "Cant send email verification. Too many request!");
                } finally {
                  isLoad.value = false;
                }
              },
            );
          }
        } else {
          // jika input login = null,
          isLoad.value = false;
        }
      } on FirebaseAuthException catch (err) {
        isLoad.value = false;
        if (err.code == "wrong-password") {
          // password salah
          passCtrl.clear();
          CustomSnackbar.errorSnackbar("Error", "Wrong password");
        } else if (err.code == "network-request-failed") {
          // tak ada internet
          CustomSnackbar.errorSnackbar("Error", "No internet connection");
        } else if (err.code == "user-not-found") {
          // akun tidak ditemukan
          emailCtrl.clear();
          passCtrl.clear();
          CustomSnackbar.errorSnackbar("Error", "User not found");
        } else {
          // bukan bentuk email
          CustomSnackbar.errorSnackbar("Error", "Please input valid email");
        }
      } catch (e) {
        print(e);
      } finally {
        isLoad.value = false;
      }
    } else {
      // jika email & password kosong
      CustomSnackbar.errorSnackbar(
          "Error", "You must input email and password");
    }
  }
}
