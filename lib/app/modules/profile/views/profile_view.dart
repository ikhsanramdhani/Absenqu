import 'package:absenqu/app/controllers/page_index_controller.dart';
import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_bottomnavbar.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:absenqu/app/data/widgets/menu_tile.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageIndexCtrl = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: CustomBottomNavbar(),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }

              if (snapshot.hasData) {
                Map<String, dynamic> student = snapshot.data!.data()!;
                String defaultImage =
                    "https://ui-avatars.com/api/?name=${student["name"]}";
                return ListView(
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
                            child: Image.network(
                              student["photoUrl"] ?? defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 4, top: 16),
                          child: Text(
                            student["name"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          "Student",
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
                              title: "Update Profile",
                              icon: SvgPicture.asset(
                                  'lib/app/data/assets/icons/profile-1.svg'),
                              onTap: () => Get.toNamed(Routes.UPDATE_PROFILE,
                                  arguments: student)),
                          MenuTile(
                              title: "Change Password",
                              icon: SvgPicture.asset(
                                  'lib/app/data/assets/icons/password.svg'),
                              onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD)),
                          MenuTile(
                              title: "Sign Out",
                              icon: SvgPicture.asset(
                                  'lib/app/data/assets/icons/logout.svg'),
                              onTap: () => controller.logout()),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Loading();
              }
            }));
  }
}
