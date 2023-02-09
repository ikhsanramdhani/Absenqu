import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PresenceCard extends StatelessWidget {
  const PresenceCard(
      {super.key, required this.todayPresence, required this.userData});
  final Map<String, dynamic>? todayPresence;
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
              image: AssetImage('lib/app/data/assets/images/pattern-1.png'),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Student",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              userData["nim"],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
                color: AppColor.primarySoft,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: const Text(
                        "Check In",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    Text(
                      todayPresence?["in"] != null
                          ? DateFormat.jms().format(
                              DateTime.parse(todayPresence!["in"]["date"]))
                          : "-",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )
                  ],
                )),
                Container(
                  width: 1.5,
                  height: 24,
                  color: Colors.white,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: const Text(
                        "Check Out",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    Text(
                      todayPresence?["out"] != null
                          ? DateFormat.jms().format(
                              DateTime.parse(todayPresence!["out"]["date"]))
                          : "-",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
