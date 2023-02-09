import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AllPresenceController extends GetxController {
  DateTime? dateStart;
  DateTime dateEnd = DateTime.now();

  Future getAllPresence() async {
    String uid = auth.currentUser!.uid;

    if (dateStart == null) {
      // get all absen sampai saat ini
      return await firestore
          .collection('student')
          .doc(uid)
          .collection('absen')
          .where('date', isLessThanOrEqualTo: dateEnd.toString())
          .orderBy('date', descending: true)
          .get();
    } else {
      return await firestore
          .collection('student')
          .doc(uid)
          .collection('absen')
          .where('date', isGreaterThanOrEqualTo: dateStart.toString())
          .where('date',
              isLessThanOrEqualTo:
                  dateEnd.add(const Duration(days: 1)).toString())
          .orderBy('date', descending: true)
          .get();
    }
  }

  void pickDate(DateTime pickDateStart, DateTime pickDateEnd) {
    dateStart = pickDateStart;
    dateEnd = pickDateEnd;
    update();
  }
}
