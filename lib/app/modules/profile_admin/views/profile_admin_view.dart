import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/menu_tile.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminView extends GetView<ProfileAdminController> {
  const ProfileAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
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
            ),
          ),
        ),
        extendBody: true,
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(vertical: 36),
          children: [
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 124,
                    height: 124,
                    color: Colors.blue,
                    child: Image.asset(
                      'lib/app/data/assets/images/splash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4, top: 16),
                  child: const Text(
                    "Nur Ikhsan Ramdhani",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  "Administrator",
                  style: TextStyle(color: AppColor.secondarySoft),
                ),
              ],
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.only(top: 42),
              child: Column(
                children: [
                  MenuTile(
                      title: "Add Student",
                      icon: SvgPicture.asset(
                          'lib/app/data/assets/icons/people.svg'),
                      onTap: () => Get.toNamed(Routes.ADD_STUDENT)),
                  MenuTile(
                      title: "Change Password",
                      icon: SvgPicture.asset(
                          'lib/app/data/assets/icons/password.svg'),
                      onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD)),
                  MenuTile(
                      title: "Sign Out",
                      icon: SvgPicture.asset(
                          'lib/app/data/assets/icons/logout.svg'),
                      onTap: () => Get.offAllNamed(Routes.LOGIN)),
                ],
              ),
            )
          ],
        ));
  }
}
