import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/add_student_controller.dart';

class AddStudentView extends GetView<AddStudentController> {
  const AddStudentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Student',
            style: TextStyle(color: AppColor.secondary, fontSize: 14),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon:
                  SvgPicture.asset('lib/app/data/assets/icons/arrow-left.svg')),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                width: Get.width,
                height: 1,
                color: AppColor.secondaryExtraSoft,
              )),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.all(20),
          children: [
            CustomInput(
              controller: controller.nimController,
              label: 'NIM',
              hint: '22040000',
            ),
            CustomInput(
              controller: controller.nameController,
              label: 'Full Name',
              hint: 'Johnn Doe',
            ),
            CustomInput(
              controller: controller.emailController,
              label: 'Email',
              hint: 'youremail@email.com',
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(0),
              width: Get.width,
              child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoad.isFalse) {
                      await controller.addStudent();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.primary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "Add Student",
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ));
  }
}
