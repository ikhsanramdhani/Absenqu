import 'package:absenqu/app/data/widgets/custom_dialog.dart';
import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class UpdateStudentController extends GetxController {
  TextEditingController nimCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  RxBool isLoad = false.obs;

  Future<void> updateStudent(String uid) async {
    if (nimCtrl.text.isNotEmpty) {
      isLoad.value = true;

      try {
        var dataUpdate = {"nim": nimCtrl.text};
        await firestore.collection('student').doc(uid).update(dataUpdate);
        await CustomSnackbar.successSnackbar(
            "Success", "Success update account ${emailCtrl.text}");
      } catch (e) {
        CustomSnackbar.errorSnackbar("Error", "Error : ${e.toString()}");
      } finally {
        isLoad.value = false;
      }
    } else {
      CustomSnackbar.errorSnackbar("Error", "You must input all form");
    }
  }

  Future<void> deleteStudent(String uid) async {
    DocumentReference documentReference =
        firestore.collection('student').doc(uid);

    CustomDialog.showPresenceAlert(
      title: "Delete Student",
      message: "Are you sure to delete this student?",
      onConfirm: () async {
        await documentReference.delete();
        CustomSnackbar.successSnackbar("Success", "Success delete student");
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
