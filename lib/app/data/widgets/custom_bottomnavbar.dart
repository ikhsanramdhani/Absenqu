import 'package:absenqu/app/controllers/page_index_controller.dart';
import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomBottomNavbar extends GetView<PageIndexController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: Get.width,
      color: Colors.transparent,
      child: Stack(
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Positioned(
              bottom: 0,
              child: Container(
                height: 65,
                width: Get.width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: AppColor.secondaryExtraSoft, width: 1))),
                child: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () => controller.changePage(0),
                        child: Container(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                // ignore: unrelated_type_equality_checks
                                child: controller.pageIndex == 0
                                    ? SvgPicture.asset(
                                        'lib/app/data/assets/icons/home-active.svg')
                                    : SvgPicture.asset(
                                        'lib/app/data/assets/icons/home.svg'),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 10, color: AppColor.secondary),
                              )
                            ],
                          ),
                        ),
                      )),
                      Container(
                        width: Get.width / 4,
                        margin: const EdgeInsets.only(top: 24),
                        alignment: Alignment.center,
                        child: Text(
                          "Presence",
                          style: TextStyle(
                              color: AppColor.secondary, fontSize: 10),
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () => controller.changePage(2),
                        child: Container(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                // ignore: unrelated_type_equality_checks
                                child: controller.pageIndex == 2
                                    ? SvgPicture.asset(
                                        'lib/app/data/assets/icons/profile-active.svg')
                                    : SvgPicture.asset(
                                        'lib/app/data/assets/icons/profile.svg'),
                              ),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 32,
              child: Obx(
                () => SizedBox(
                    width: 64,
                    height: 64,
                    child: FloatingActionButton(
                      onPressed: () => controller.changePage(1),
                      backgroundColor: AppColor.primary,
                      elevation: 0,
                      child: controller.isLoad.isFalse
                          ? SvgPicture.asset(
                              'lib/app/data/assets/icons/fingerprint.svg',
                              color: Colors.white,
                            )
                          : Center(
                              child: LoadingAnimationWidget.hexagonDots(
                                  color: Colors.white, size: 30),
                            ),
                      // child: CircularProgressIndicator(
                      //   color: Colors.white,
                      // )),
                    )),
              ))
        ],
      ),
    );
  }
}
