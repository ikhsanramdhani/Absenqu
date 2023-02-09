import 'package:absenqu/app/data/widgets/custom_dialog.dart';
import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AddStudentController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passAdminController = TextEditingController();

  RxBool isLoad = false.obs;
  RxBool isLoadAdd = false.obs;

  Future<void> addStudent() async {
    if (nimController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoad.value = true;
      CustomDialog.confirmAdmin(
          title: "Admin Confirmation",
          message: 'You need to confirm that you are an administrator',
          onCancel: () {
            isLoad.value = false;
            passAdminController.clear();
            Get.back();
          },
          onConfirm: () async {
            if (isLoadAdd.isFalse) {
              await processAdd();
            }
            isLoad.value = false;
          },
          controller: passAdminController);
    } else {
      CustomSnackbar.errorSnackbar("Error", "You need to fill all form");
    }
  }

  Future<void> processAdd() async {
    if (passAdminController.text.isNotEmpty) {
      isLoadAdd.value = true;

      try {
        String adminEmail = auth.currentUser!.email!;

        await auth.signInWithEmailAndPassword(
            email: adminEmail, password: passAdminController.text);

        // bikin akun
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailController.text, password: "student");

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await firestore.collection('student').doc(uid).set({
            "nim": nimController.text,
            "name": nameController.text,
            "email": emailController.text,
            "uid": uid,
            "role": "student",
            "active": "false",
            "createdAt": DateTime.now().toString()
          });
          await userCredential.user!.sendEmailVerification();

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: adminEmail, password: passAdminController.text);
          Get.back();
          Get.back();
          CustomSnackbar.successSnackbar("Success", "Add Student success");
        }
        nimController.clear();
        emailController.clear();
        nameController.clear();
      } on FirebaseAuthException catch (err) {
        if (err.code == "weak-password") {
          // short password
          Get.back();
          passAdminController.clear();
          CustomSnackbar.errorSnackbar("Error", "Password too short");
        } else if (err.code == "email-already-in-use") {
          // email already
          Get.back();
          passAdminController.clear();
          CustomSnackbar.errorSnackbar("Error", "Email already in use");
        } else if (err.code == "wrong-password") {
          // wrong password admin
          Get.back();
          CustomSnackbar.errorSnackbar("Error", "Wrong password!");
          passAdminController.clear();
        } else {
          Get.back();
          passAdminController.clear();
          CustomSnackbar.errorSnackbar("Error", "Your error is : ${err.code}");
        }
      } catch (e) {
        print(e);
      } finally {
        isLoadAdd.value = false;
      }
    } else {
      isLoad.value = false;
      CustomSnackbar.errorSnackbar("Error", "You must input password");
    }
  }
}
