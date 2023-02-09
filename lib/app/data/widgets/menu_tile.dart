import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColor.secondaryExtraSoft, width: 1))),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColor.primaryExtraSoft,
                  borderRadius: BorderRadius.circular(100)),
              child: icon,
            ),
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDanger ? AppColor.error : AppColor.secondary),
            ))
          ],
        ),
      ),
    );
  }
}
