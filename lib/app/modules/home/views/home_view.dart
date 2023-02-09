import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_bottomnavbar.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:absenqu/app/data/widgets/presence_card.dart';
import 'package:absenqu/app/data/widgets/presence_tile.dart';
import 'package:absenqu/app/modules/home_admin/views/home_admin_view.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loading(),
            );
          }

          if (snapshot.hasData) {
            var student = snapshot.data.data();
            String defaultImage =
                "https://ui-avatars.com/api/?name=${student["name"]}";

            if (student["role"] == "admin") {
              return HomeAdminView();
            } else {
              return Scaffold(
                  bottomNavigationBar: CustomBottomNavbar(),
                  extendBody: true,
                  body: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 36),
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        width: Get.width,
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                width: 42,
                                height: 42,
                                child: Image.network(
                                  student["photoUrl"] ?? defaultImage,
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.asset(
                                //     'lib/app/data/assets/images/splash.png',
                                //     fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.secondarySoft),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  student["name"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      StreamBuilder(
                          stream: controller.streamTodayAbsen(),
                          builder: (context, snapshot) {
                            var todayPresence = snapshot.data?.data();
                            return PresenceCard(
                                todayPresence: todayPresence,
                                userData: student);
                          }),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 12, bottom: 24, left: 5),
                        child: Text(
                          student["address"] ?? "Location not found",
                          style: TextStyle(
                              fontSize: 12, color: AppColor.secondarySoft),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 84,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryExtraSoft,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: const Text(
                                      "Distance From School",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.schoolDistance.value,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () => controller.launchSchoolOnMaps(),
                              child: Container(
                                height: 84,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryExtraSoft,
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'lib/app/data/assets/images/map.JPG'),
                                        fit: BoxFit.cover,
                                        opacity: 0.3)),
                                child: const Text(
                                  "Open In Maps",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Presence History",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () =>
                                    Get.toNamed(Routes.ALL_PRESENCE),
                                // style: TextButton.styleFrom(primary: color.primary),
                                child: Text(
                                  "Show All",
                                  style: TextStyle(color: AppColor.primary),
                                ))
                          ],
                        ),
                      ),
                      StreamBuilder(
                          stream: controller.streamLastAbsen(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Loading();
                            }

                            if (snapshot.data.docs.length == 0 ||
                                snapshot.data.docs == null) {
                              return SizedBox(
                                height: Get.height * 0.125,
                                child: const Center(
                                  child: Text("No History"),
                                ),
                              );
                            }

                            var listPresence = snapshot.data!.docs;

                            return ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> dataPresence =
                                      listPresence[index].data();
                                  return PresenceTile(
                                    dataPresence: dataPresence,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 16,
                                    ),
                                itemCount: listPresence.length);
                          }),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ));
            }
          } else {
            return Center(
              child: Loading(),
            );
          }
        });
  }
}
