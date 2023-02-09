import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  const DetailPresenceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> presenceData = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Presence Detail',
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
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: AppColor.secondaryExtraSoft, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Check In",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            presenceData["in"] != null
                                ? DateFormat.jm().format(
                                    DateTime.parse(presenceData["in"]["date"]))
                                : "-",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd()
                            .format(DateTime.parse(presenceData["date"])),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    "Distance",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      presenceData["in"]?["distance"] != null
                          ? "${presenceData["in"]!["distance"].toString().split(".").first}m"
                          : "-",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    presenceData["in"] != null
                        ? presenceData["in"]["address"]
                        : "-",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: AppColor.secondaryExtraSoft, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Check Out",
                            style: TextStyle(color: AppColor.secondary),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            presenceData["out"] != null
                                ? DateFormat.jm().format(
                                    DateTime.parse(presenceData["out"]["date"]))
                                : "-",
                            style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd()
                            .format(DateTime.parse(presenceData["date"])),
                        style: TextStyle(color: AppColor.secondary),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Distance",
                    style: TextStyle(color: AppColor.secondary),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      presenceData["out"]?["distance"] != null
                          ? "${presenceData["out"]!["distance"].toString().split(".").first}m"
                          : "-",
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(color: AppColor.secondary),
                  ),
                  Text(
                    presenceData["out"] != null
                        ? presenceData["out"]["address"]
                        : "-",
                    style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
