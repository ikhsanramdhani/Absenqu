import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/custom_dialog.dart';
import 'package:absenqu/app/data/widgets/custom_snackbar.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:absenqu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/home_admin_controller.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  const HomeAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: StreamBuilder(
            stream: controller.streamStudents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              if (snapshot.hasData) {
                return ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
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
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.PROFILE_ADMIN),
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                width: 42,
                                height: 42,
                                child: Image.asset(
                                    'lib/app/data/assets/images/splash.png',
                                    fit: BoxFit.cover),
                              ),
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
                              const Text(
                                "Administrator",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            image: AssetImage(
                                'lib/app/data/assets/images/pattern-1.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Administrator",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4, bottom: 12),
                            child: const Text(
                              "∞",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 24, bottom: 12, left: 5),
                      child: Text(
                        "List Student of Polytechnic Gajah Tunggal",
                        style: TextStyle(
                            fontSize: 12, color: AppColor.secondarySoft),
                      ),
                    ),
                    ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5,
                            ),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(2),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data!.docs.length);
                          var data = snapshot.data!.docs[index].data();
                          if (snapshot.data!.docs.length == 1) {
                            return const Center(
                              child: Text("Student not found"),
                            );
                          }
                          if (data["role"] == "admin") {
                            return const SizedBox();
                          } else {
                            return InkWell(
                              onTap: () {
                                CustomDialog.showAlertAdmin(
                                  title: "Announcement",
                                  message:
                                      "What action will be taken on ${data["email"]}?",
                                  onDelete: () async {
                                    await controller.deleteStudent(data["uid"]);
                                    Get.back();
                                    CustomSnackbar.successSnackbar(
                                        "Success", "Success delete student");
                                  },
                                  onEdit: () async {
                                    await Get.toNamed(Routes.UPDATE_STUDENT,
                                        arguments: data);
                                    Get.back();
                                  },
                                  onCancel: () => Get.back(),
                                );
                              },
                              child: ListTile(
                                title: Text(data["name"]),
                                subtitle: Text(data["email"]),
                                leading: CircleAvatar(
                                  backgroundColor: data["active"] == "true"
                                      ? Colors.green
                                      : Colors.red,
                                  child: data["active"] == "true"
                                      ? const Icon(Icons.check_circle_outline)
                                      : const Icon(Icons.error_outline),
                                ),
                              ),
                            );
                          }

                          // return ListTile(
                          //   title: Text(data["name"] != null
                          //       ? "  ${data["name"]}"
                          //       : "-"),
                          //   subtitle: Text(data["email"] != null
                          //       ? "  ${data["email"]}"
                          //       : "-"),
                          //   leading: CircleAvatar(
                          //     child: Image.network(data["photoUrl"] ??
                          //         "https://ui-avatars.com/api/?name=${data["name"]}"),
                          //   ),
                          // );

                          // Slidable(
                          //     startActionPane: ActionPane(
                          //         motion: const DrawerMotion(),
                          //         dismissible: DismissiblePane(onDismissed: () {
                          //           print("s");
                          //         }),
                          //         children: [
                          //           SlidableAction(
                          //             backgroundColor: AppColor.error,
                          //             onPressed: (context) => print("Delete"),
                          //             icon: Icons.delete,
                          //           ),
                          //           SlidableAction(
                          //             onPressed: (context) => print("Edit"),
                          //             icon: Icons.edit,
                          //           ),
                          //         ]),
                          //     child: ListView.builder(
                          //         padding: const EdgeInsets.all(20),
                          //         physics: const BouncingScrollPhysics(
                          //             parent: AlwaysScrollableScrollPhysics()),
                          //         itemBuilder: (context, index) {
                          //           var data =
                          //               student[index].data() as Map<String, dynamic>;

                          //           return ListTile(
                          //             title: Text("${data["name"]}"),
                          //             subtitle: Text("${data["email"]}"),
                          //             leading: CircleAvatar(
                          //               child: Image.network(data["photoUrl"] ??
                          //                   "https://ui-avatars.com/api/?name=${data["name"]}"),
                          //             ),
                          //           );
                          //         },
                          //         // separatorBuilder: (context, index) =>
                          //         //     const SizedBox(
                          //         //       height: 10,
                          //         //     ),
                          //         itemCount: student.length))
                        })
                  ],
                );
              } else {
                return const Center(
                  child: Text("No student"),
                );
              }
            }));
  }
}
