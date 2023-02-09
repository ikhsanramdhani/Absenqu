import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColor.primaryExtraSoft)),
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: ListTile(
        title: const Text("Joko Anwar"),
        subtitle: const Text("jokoanwar@gmail.com"),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage:
              AssetImage('lib/app/data/assets/images/student_profile.jpeg'),
        ),
      ),
    );
  }
}
