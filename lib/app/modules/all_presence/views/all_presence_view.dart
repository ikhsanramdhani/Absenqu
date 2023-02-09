import 'package:absenqu/app/data/models/app_color.dart';
import 'package:absenqu/app/data/widgets/loading.dart';
import 'package:absenqu/app/data/widgets/presence_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/all_presence_controller.dart';

class AllPresenceView extends GetView<AllPresenceController> {
  const AllPresenceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'All Presence',
            style: TextStyle(color: AppColor.secondary, fontSize: 14),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon:
                  SvgPicture.asset('lib/app/data/assets/icons/arrow-left.svg')),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(bottom: 8, top: 8, right: 8),
              child: ElevatedButton(
                  onPressed: () async {
                    var picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2024),
                        confirmText: "Done");
                    controller.pickDate(picked!.start, picked.end);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: SvgPicture.asset(
                    'lib/app/data/assets/icons/filter.svg',
                    color: AppColor.secondary,
                  )),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              width: Get.width,
              height: 1,
              color: AppColor.secondaryExtraSoft,
            ),
          ),
        ),
        body: GetBuilder<AllPresenceController>(
          builder: (controller) {
            return FutureBuilder(
              future: controller.getAllPresence(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }

                if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                  return SizedBox(
                    height: Get.height * 0.125,
                    child: const Center(
                      child: Text("No history presence"),
                    ),
                  );
                }
                var data = snapshot.data!.docs;

                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    var presenceData = data[index].data();
                    return PresenceTile(
                      dataPresence: presenceData,
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
