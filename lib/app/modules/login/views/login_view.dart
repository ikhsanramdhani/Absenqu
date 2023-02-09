import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
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
                        "Hi ",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      Text("Student",
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.65,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 20, top: 36, right: 20),
              // padding: const EdgeInsets.fromLTRB(20, 36, 20, 0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    // email field
                    Container(
                      width: Get.width,
                      padding:
                          const EdgeInsets.only(left: 14, right: 14, top: 4),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: AppColor.secondaryExtraSoft)),
                      child: TextField(
                        controller: controller.emailCtrl,
                        style: const TextStyle(fontSize: 14),
                        textInputAction: TextInputAction.next,
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
                            fontFamily: 'inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.secondarySoft,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        width: Get.width,
                        padding:
                            const EdgeInsets.only(left: 14, right: 14, top: 4),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1, color: AppColor.secondaryExtraSoft)),
                        child: TextField(
                          controller: controller.passCtrl,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 1,
                          obscureText: controller.obsecure.value,
                          decoration: InputDecoration(
                              label: Text(
                                "Password",
                                style: TextStyle(
                                    color: AppColor.secondarySoft,
                                    fontSize: 14),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: InputBorder.none,
                              hintText: "*************",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.obsecure.value =
                                        !controller.obsecure.value;
                                  },
                                  icon: controller.obsecure.value
                                      ? SvgPicture.asset(
                                          'lib/app/data/assets/icons/show.svg',
                                          height: 22,
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerRight,
                                        )
                                      : SvgPicture.asset(
                                          'lib/app/data/assets/icons/hide.svg',
                                          height: 22,
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerRight)),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondarySoft)),
                        ),
                      ),
                    ),
                    controller.isLoad.isFalse
                        ? Container(
                            padding: const EdgeInsets.all(0),
                            width: Get.width,
                            child: ElevatedButton(
                                onPressed: () => controller.login(),
                                // onPressed: () => (controller.isLoad.isFalse)
                                //     ? Get.offAllNamed(Routes.HOME)
                                //     : Get.dialog(Loading()),
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    elevation: 0,
                                    backgroundColor: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8))
                                    // primary: AppColor.primary
                                    ),
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        : Stack(
                            children: [
                              Loading(),
                            ],
                          ),
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                                color: AppColor.secondarySoft, fontSize: 13),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
