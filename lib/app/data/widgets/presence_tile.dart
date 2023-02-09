import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresenceTile extends StatelessWidget {
  const PresenceTile({super.key, required this.dataPresence});
  final Map<String, dynamic> dataPresence;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.DETAIL_PRESENCE, arguments: dataPresence),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColor.primaryExtraSoft)),
        padding: const EdgeInsets.fromLTRB(14, 20, 0, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Check In",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      dataPresence["in"] != null
                          ? DateFormat.jm().format(
                              DateTime.parse(dataPresence["in"]["date"]))
                          : "-",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  width: 11,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Check Out",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      dataPresence["out"] != null
                          ? DateFormat.jm().format(
                              DateTime.parse(dataPresence["out"]["date"]))
                          : "-",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                DateFormat.yMMMMEEEEd()
                    .format(DateTime.parse(dataPresence["date"])),
                style: TextStyle(fontSize: 10, color: AppColor.secondarySoft),
              ),
            )
          ],
        ),
      ),
    );
  }
}
