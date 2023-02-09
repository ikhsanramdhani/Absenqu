import 'dart:io';

import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nimCtrl.text = data["nim"];
    controller.nameCtrl.text = data["name"];
    controller.emailCtrl.text = data["email"];
    String defaultImage = "https://ui-avatars.com/api/?name=${data["name"]}";
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
                      controller.updateProfile(data["uid"]);
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
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                children: [
                  GetBuilder<UpdateProfileController>(
                    builder: (controller) {
                      if (controller.image != null) {
                        return ClipOval(
                          child: Container(
                            width: 98,
                            height: 98,
                            color: AppColor.primaryExtraSoft,
                            child: Image.file(
                              File(controller.image!.path),
                              fit: BoxFit.cover,
                              // child: Image.asset(
                              //   'lib/app/data/assets/images/splash.png',
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return ClipOval(
                          child: Container(
                            width: 98,
                            height: 98,
                            color: AppColor.primaryExtraSoft,
                            child: Image.network(
                              data["photoUrl"] ?? defaultImage,
                              fit: BoxFit.cover,
                              // child: Image.asset(
                              //   'lib/app/data/assets/images/splash.png',
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            child: SvgPicture.asset(
                                'lib/app/data/assets/icons/camera.svg')),
                      ))
                ],
              ),
            ),
            CustomInput(
              controller: controller.nameCtrl,
              label: "Full Name",
              hint: "Your Full Name",
              margin: EdgeInsets.only(bottom: 16, top: 42),
            ),
            CustomInput(
              controller: controller.nimCtrl,
              label: "Nim",
              hint: "100000000000",
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
