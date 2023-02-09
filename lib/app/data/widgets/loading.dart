import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: LoadingAnimationWidget.prograssiveDots(
            color: AppColor.primary, size: 50),
      ),
    );
  }
}
