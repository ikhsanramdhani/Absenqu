import 'package:absenqu/app/data/widgets/custom_dialog.dart';
import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxBool isLoad = false.obs;

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        isLoad.value = true;
        Map<String, dynamic> positionResponse = await determinePosition();
        if (positionResponse["error"]) {
          CustomSnackbar.errorSnackbar("Error", positionResponse["message"]);
          isLoad.value = false;
        } else {
          Position position = positionResponse["position"];
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          print(placemarks);
          String address =
              "${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
          await updatePosition(position, address);

          // cek jarak ke 2 koordinat ke poltek gt
          double distance = Geolocator.distanceBetween(
              -6.1930851, 106.5690701, position.latitude, position.longitude);
          await absen(position, address, distance);
          isLoad.value = false;
        }
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }

  Future<void> absen(Position position, String address, double distance) async {
    String uid = auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colAbsen =
        firestore.collection('student').doc(uid).collection('absen');

    QuerySnapshot<Map<String, dynamic>> snapAbsen = await colAbsen.get();

    DateTime timeNow = DateTime.now();
    String dateUid = DateFormat.yMd().format(timeNow).replaceAll("/", "-");

    if (distance <= 300) {
      if (snapAbsen.docs.isEmpty) {
        // belum pernah absen sama sekali dan set absen masuk
        CustomDialog.showPresenceAlert(
          title: "Are you want to check in?",
          message: "you need to confirm before you\ncan do presence now",
          onCancel: () => Get.back(),
          onConfirm: () async {
            await colAbsen.doc(dateUid).set({
              "date": timeNow.toString(),
              "in": {
                "date": timeNow.toString(),
                "lat": position.latitude,
                "long": position.longitude,
                "address": address,
                "distance": distance
              }
            });
            Get.back();
            CustomSnackbar.successSnackbar("Success", "Success Check In");
          },
        );
      } else {
        // sudah pernah absen -> cek hari ini udh masuk / keluar
        DocumentSnapshot<Map<String, dynamic>> todayDoc =
            await colAbsen.doc(dateUid).get();

        // jika sudah absen masuk, maka skrg absen keluar
        if (todayDoc.exists) {
          Map<String, dynamic>? dataAbsenMap = todayDoc.data();

          if (dataAbsenMap?["out"] != null) {
            // sudah absen masuk dan keluar
            CustomSnackbar.successSnackbar(
                "Success", "You already check in and check out");
          } else {
            // absen keluar
            CustomDialog.showPresenceAlert(
              title: "Are you want to check out?",
              message: "You need to confirm before you\ncan do presence now",
              onCancel: () => Get.back(),
              onConfirm: () async {
                await colAbsen.doc(dateUid).update({
                  "out": {
                    "date": timeNow.toString(),
                    "lat": position.latitude,
                    "long": position.longitude,
                    "address": address,
                    "distance": distance
                  }
                });
                Get.back();
                CustomSnackbar.successSnackbar("Success", "Success Check Out");
              },
            );
          }
        } else {
          // jika belum absen masuk, maka absen masuk
          // absen masuk
          CustomDialog.showPresenceAlert(
            title: "Are you want to check in?",
            message: "you need to confirm before you\ncan do presence now",
            onCancel: () => Get.back(),
            onConfirm: () async {
              await colAbsen.doc(dateUid).set({
                "date": timeNow.toString(),
                "in": {
                  "date": timeNow.toString(),
                  "lat": position.latitude,
                  "long": position.longitude,
                  "address": address,
                  "distance": distance
                }
              });
              Get.back();
              CustomSnackbar.successSnackbar("Success", "Success Check In");
            },
          );
        }
      }
    } else {
      CustomSnackbar.errorSnackbar(
          "Error", "You are out of range polytechnic gajah tunggal");
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;

    await firestore.collection('student').doc(uid).update({
      "position": {"lat": position.latitude, "long": position.longitude},
      "address": address,
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
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
}
