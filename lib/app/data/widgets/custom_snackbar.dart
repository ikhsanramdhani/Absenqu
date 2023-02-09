import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static errorSnackbar(String? title, String? message) {
    Get.rawSnackbar(
        duration: const Duration(seconds: 4),
        forwardAnimationCurve: Curves.easeOutBack,
        dismissDirection: DismissDirection.horizontal,
        messageText: Row(
          children: [
            SvgPicture.asset(
              'lib/app/data/assets/icons/info-circle.svg',
              color: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Error",
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  message ?? "Add your error message here",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ))
          ],
        ),
        backgroundColor: const Color(0xFFD00E0E),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 8,
        snackPosition: SnackPosition.TOP);
  }

  static successSnackbar(String? title, String? message) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 4),
      forwardAnimationCurve: Curves.easeOutBack,
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "lib/app/data/assets/icons/success-circle.svg",
            color: Colors.white,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Success",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'inter',
                    ),
                  ),
                ),
                Text(
                  message ?? "Add your success message here",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF16AE26),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    );
  }
}
