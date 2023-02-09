import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/update_student_controller.dart';

class UpdateStudentView extends GetView<UpdateStudentController> {
  const UpdateStudentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments;
    controller.nameCtrl.text = data["name"];
    controller.nimCtrl.text = data["nim"];
    controller.emailCtrl.text = data["email"];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(color: AppColor.secondary, fontSize: 14),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon:
                  SvgPicture.asset('lib/app/data/assets/icons/arrow-left.svg')),
          actions: [
            Obx(
              () => TextButton(
                  onPressed: () {
                    if (controller.isLoad.isFalse) {
                      controller.updateStudent(data["uid"]);
                    }
                  },
                  style: TextButton.styleFrom(primary: AppColor.primary),
                  child: controller.isLoad.isFalse
                      ? const Text("Done")
                      : LoadingAnimationWidget.hexagonDots(
                          color: AppColor.primary, size: 20)),
            )
          ],
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
          padding: const EdgeInsets.all(20),
          children: [
            CustomInput(
                controller: controller.nimCtrl,
                label: "Nim",
                hint: "22040000",
                margin: const EdgeInsets.only(bottom: 16, top: 12)),
            CustomInput(
              controller: controller.nameCtrl,
              label: "Full Name",
              hint: "Your Full Name",
              disabled: true,
            ),
            CustomInput(
              controller: controller.emailCtrl,
              label: "Email",
              hint: "youremail@email.com",
              disabled: true,
            ),
          ],
        ));
  }
}
