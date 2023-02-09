import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_input.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Change Password',
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
            Obx(
              () => CustomInput(
                controller: controller.currPassCtrl,
                label: 'Old Password',
                hint: '*************',
                obsecureText: controller.currObs.value,
                suffixIcon: IconButton(
                  icon: controller.currObs.isFalse
                      ? SvgPicture.asset('lib/app/data/assets/icons/show.svg')
                      : SvgPicture.asset('lib/app/data/assets/icons/hide.svg'),
                  onPressed: () {
                    controller.currObs.value = !controller.currObs.value;
                  },
                ),
              ),
            ),
            Obx(
              () => CustomInput(
                controller: controller.newPassCtrl,
                label: 'New Password',
                hint: '*************',
                obsecureText: controller.newObs.value,
                suffixIcon: IconButton(
                  icon: controller.newObs.isFalse
                      ? SvgPicture.asset('lib/app/data/assets/icons/show.svg')
                      : SvgPicture.asset('lib/app/data/assets/icons/hide.svg'),
                  onPressed: () {
                    controller.newObs.value = !controller.newObs.value;
                  },
                ),
              ),
            ),
            Obx(
              () => CustomInput(
                controller: controller.confNewPassCtrl,
                label: 'Confirm New Password',
                hint: '*************',
                obsecureText: controller.confObs.value,
                suffixIcon: IconButton(
                  icon: controller.confObs.isFalse
                      ? SvgPicture.asset('lib/app/data/assets/icons/show.svg')
                      : SvgPicture.asset('lib/app/data/assets/icons/hide.svg'),
                  onPressed: () {
                    controller.confObs.value = !controller.confObs.value;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => controller.isLoad.isFalse
                  ? Container(
                      padding: const EdgeInsets.all(0),
                      width: Get.width,
                      child: ElevatedButton(
                          onPressed: () {
                            if (controller.isLoad.isFalse) {
                              controller.changePassword();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primary,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text(
                            "Change Password",
                            style: TextStyle(fontSize: 16),
                          )),
                    )
                  : Loading(),
            )
          ],
        ));
  }
}
