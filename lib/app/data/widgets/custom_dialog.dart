import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_input.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialog {
  static confirmAdmin({
    required String title,
    required String message,
    required void Function() onConfirm,
    required void Function() onCancel,
    required TextEditingController controller,
  }) {
    Get.defaultDialog(
        title: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        radius: 8,
        titlePadding: EdgeInsets.zero,
        titleStyle: const TextStyle(fontSize: 0),
        content: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      height: 150 / 100,
                    ),
                  ),
                ],
              ),
            ),
            CustomInput(
              margin: const EdgeInsets.only(bottom: 24),
              controller: controller,
              label: 'password',
              hint: '*************',
              obsecureText: true,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        primary: AppColor.primaryExtraSoft,
                        elevation: 0,
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: AppColor.secondarySoft),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text("Confirm"),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 25,
            // )
          ],
        ));
  }

  static showPresenceAlert({
    required String title,
    required String message,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
        title: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        radius: 8,
        titlePadding: EdgeInsets.zero,
        titleStyle: const TextStyle(fontSize: 0),
        content: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 32, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        primary: AppColor.primaryExtraSoft,
                        elevation: 0,
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: AppColor.secondarySoft),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text("Confirm"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  static showAlertAdmin({
    required String title,
    required String message,
    required void Function() onDelete,
    required void Function() onEdit,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
        title: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        radius: 8,
        titlePadding: EdgeInsets.zero,
        titleStyle: const TextStyle(fontSize: 0),
        content: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 32, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        primary: AppColor.primaryExtraSoft,
                        elevation: 0,
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: AppColor.secondarySoft),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onEdit,
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text("Edit"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: onDelete,
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.error,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
