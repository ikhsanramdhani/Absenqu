import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class HomeAdminController extends GetxController {
  Stream streamStudents() async* {
    yield* firestore
        .collection('student')
        .orderBy('active', descending: true)
        .snapshots();
  }

  Future<void> deleteStudent(String uid) async {
    DocumentReference documentReference =
        firestore.collection('student').doc(uid);

    await documentReference.delete();
  }
}
