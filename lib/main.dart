import 'package:absenqu/app/controllers/page_index_controller.dart';
import 'package:absenqu/app/data/widgets/splash_screen.dart';
import 'package:absenqu/app/modules/home_admin/controllers/home_admin_controller.dart';
import 'package:absenqu/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Absenqu());
    Get.put(PageIndexController(), permanent: true);
    Get.put(HomeAdminController(), permanent: true);
  });
}

FirebaseAuth auth = FirebaseAuth.instance;

class Absenqu extends StatelessWidget {
  const Absenqu({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder(
  //       stream: auth.authStateChanges(),
  //       builder: (context, snapshot) {
  //         print("Snap : ${snapshot.data}");
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return FutureBuilder(
  //             future: Future.delayed(const Duration(seconds: 3)),
  //             builder: (context, snapshots) {
  //               return const SplashScreen();
  //             },
  //           );
  //         }
  //         return GetMaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           title: "Absenqu",
  //           initialRoute: (snapshot.data != null) ? Routes.HOME : Routes.LOGIN,
  //           getPages: AppPages.routes,
  //         );

  // return FutureBuilder(
  //     future: Future.delayed(const Duration(seconds: 2)),
  //     builder: (context, snapshots) {
  //       if (snapshots.connectionState == ConnectionState.waiting) {
  //         return const SplashScreen();
  //       } else {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const SplashScreen();
  //         } else {
  //           return GetMaterialApp(
  //             debugShowCheckedModeBanner: false,
  //             title: "Absenqu",
  //             initialRoute:
  //                 (snapshot.data != null) ? Routes.HOME : Routes.LOGIN,
  //             getPages: AppPages.routes,
  //           );
  //         }
  //       }
  //     });

  //       });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder(
  //       stream: auth.authStateChanges(),
  //       builder: (context, snapshot) {
  //         print("Snap : ${snapshot.data}");
  //         return FutureBuilder(
  //             future: Future.delayed(const Duration(seconds: 2)),
  //             builder: (context, snapshots) {
  //               if (snapshots.connectionState == ConnectionState.waiting) {
  //                 return const SplashScreen();
  //               } else {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const SplashScreen();
  //                 } else {
  //                   return GetMaterialApp(
  //                     debugShowCheckedModeBanner: false,
  //                     title: "Absenqu",
  //                     initialRoute:
  //                         (snapshot.data != null) ? Routes.HOME : Routes.LOGIN,
  //                     getPages: AppPages.routes,
  //                   );
  //                 }
  //               }
  //             });
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return StreamBuilder(
              stream: auth.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "Absenqu",
                    initialRoute:
                        (snapshot.data != null) ? Routes.HOME : Routes.LOGIN,
                    getPages: AppPages.routes,
                  );
                }
              },
            );
          }
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder(
  //       stream: auth.authStateChanges(),
  //       builder: (context, snapshots) {
  //         print(snapshots.data);
  //         if (snapshots.connectionState == ConnectionState.waiting) {
  //           return const SplashScreen();
  //         } else {
  //           return FutureBuilder(
  //             future: Future.delayed(const Duration(seconds: 2)),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return const SplashScreen();
  //               } else {
  //                 return GetMaterialApp(
  //                   debugShowCheckedModeBanner: false,
  //                   title: "Absenqu",
  //                   initialRoute:
  //                       (snapshots.data != null) ? Routes.HOME : Routes.LOGIN,
  //                   getPages: AppPages.routes,
  //                 );
  //               }
  //             },
  //           );
  //         }
  //       });
  // }
}
