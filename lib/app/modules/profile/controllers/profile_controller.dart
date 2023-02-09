import 'package:absenqu/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class ProfileController extends GetxController {
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamData() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection('student').doc(uid).snapshots();
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
