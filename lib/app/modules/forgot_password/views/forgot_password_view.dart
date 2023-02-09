import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset(
                'lib/app/data/assets/icons/arrow-left.svg',
                color: Colors.white,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
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
                        "Forgot ",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
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
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "We will send password reset link to\nyour email.",
                          style: TextStyle(
                              color: AppColor.secondarySoft, height: 1.5),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1, color: AppColor.secondaryExtraSoft),
                    ),
                    child: TextField(
                      controller: controller.emailCtrl,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text(
                          "Email",
                          style: TextStyle(
                              color: AppColor.secondarySoft, fontSize: 14),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: InputBorder.none,
                        hintText: "youremail@email.com",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondarySoft,
                        ),
                      ),
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
                                  controller.forgotPassword();
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
                                "Send to Email",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : Stack(
                            children: [Loading()],
                          ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(0),
                  //   width: Get.width,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       CustomSnackbar.errorSnackbar("Error",
                  //           "You must input email to send link verification");
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         padding:
                  //             const EdgeInsets.symmetric(vertical: 18),
                  //         elevation: 0,
                  //         backgroundColor: color.primary,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8))),
                  //     child: const Text(
                  //       "Send to Email",
                  //       style: TextStyle(
                  //           fontSize: 16, fontWeight: FontWeight.w500),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ));
  }
}
