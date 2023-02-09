import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColor.primary,
          body: Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              padding: const EdgeInsets.all(0),
              width: Get.width * 0.5,
              height: Get.height * 0.5,
              child: Image.asset('lib/app/data/assets/images/splash.png'),
            ),
          ),
        ));
  }
}
