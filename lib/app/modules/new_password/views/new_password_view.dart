import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_input.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        extendBody: true,
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0),
              height: Get.height * 0.35,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                image: const DecorationImage(
                    image: AssetImage(
                        'lib/app/data/assets/images/pattern-1-1.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: 120,
                    height: 120,
                    child: Image.asset('lib/app/data/assets/images/splash.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "New ",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      Text("Password",
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: Get.height * 0.65,
              width: Get.width,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "New Password",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "You log in with the default password. To continue, you must create a new password.",
                          style: TextStyle(
                              color: AppColor.secondarySoft, height: 1.5),
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => CustomInput(
                      controller: controller.newPassCtrl,
                      label: 'New Password',
                      hint: '*****************',
                      obsecureText: controller.passObs.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.passObs.value =
                                !controller.passObs.value;
                          },
                          icon: (controller.passObs.isTrue)
                              ? SvgPicture.asset(
                                  'lib/app/data/assets/icons/show.svg')
                              : SvgPicture.asset(
                                  'lib/app/data/assets/icons/hide.svg')),
                    ),
                  ),
                  Obx(
                    () => CustomInput(
                      controller: controller.confPassCtrl,
                      label: 'Confirm New Password',
                      hint: '*****************',
                      obsecureText: controller.confPassObs.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.confPassObs.value =
                                !controller.confPassObs.value;
                          },
                          icon: (controller.confPassObs.isTrue)
                              ? SvgPicture.asset(
                                  'lib/app/data/assets/icons/show.svg')
                              : SvgPicture.asset(
                                  'lib/app/data/assets/icons/hide.svg')),
                    ),
                  ),
                  Obx(
                    () => controller.isLoad.isFalse
                        ? Container(
                            padding: const EdgeInsets.all(0),
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.isLoad.isFalse) {
                                  controller.newPassword();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  elevation: 0,
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : Stack(
                            children: [Loading()],
                          ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
