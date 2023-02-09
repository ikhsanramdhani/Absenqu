import 'dart:async';

import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class HomeController extends GetxController {
  RxString schoolDistance = "-".obs;
  String uid = auth.currentUser!.uid;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (Get.currentRoute == Routes.HOME) {
        getDistanceSchool().then((value) {
          schoolDistance.value = value;
        });
      }
    });
  }

  launchSchoolOnMaps() async {
    try {
      MapsLauncher.launchCoordinates(-6.1930851, 106.5690701);
    } catch (e) {
      CustomSnackbar.errorSnackbar("Error", "Error : $e");
    }
  }

  Future<String> getDistanceSchool() async {
    print("c");
    Map<String, dynamic> determinePosition = await _determinePosition();
    if (determinePosition["error"]) {
      return "-";
    } else {
      Position position = determinePosition["position"];
      double distance = Geolocator.distanceBetween(
          -6.1930851, 106.5690701, position.latitude, position.longitude);
      if (distance > 300) {
        return "${(distance / 300).toStringAsFixed(2)}km";
      } else {
        return "${distance.toStringAsFixed(2)}m";
      }
    }
  }

  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        "message":
            "Gagal mendapatkan lokasi. Pastikan Location Service dalam keadaan On",
        "error": true
      };
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message":
              "Location Service tidak bisa digunakan. Hidupkan Location Service",
          "error": true
        };
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message": "Izinkan akses lokasi untuk menggunakakan fitur absen",
        "error": true
      };
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {
      "position": position,
      "message": "Success get location",
      "error": false
    };
  }

  Stream streamUser() async* {
    yield* firestore.collection('student').doc(uid).snapshots();
  }

  Stream streamLastAbsen() async* {
    yield* firestore
        .collection('student')
        .doc(uid)
        .collection('absen')
        .orderBy('date', descending: true)
        .limitToLast(5)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayAbsen() async* {
    String todayId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    yield* firestore
        .collection('student')
        .doc(uid)
        .collection('absen')
        .doc(todayId)
        .snapshots();
  }
}
