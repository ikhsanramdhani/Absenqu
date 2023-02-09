import 'package:absenqu/app/data/models/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;

  CustomInput({
    required this.controller,
    required this.label,
    required this.hint,
    this.disabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.obsecureText = false,
    this.suffixIcon,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
        margin: widget.margin,
        decoration: BoxDecoration(
            color: widget.disabled
                ? AppColor.primaryExtraSoft
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColor.secondaryExtraSoft)),
        child: TextField(
          readOnly: widget.disabled,
          obscureText: widget.obsecureText,
          style: const TextStyle(fontSize: 14, fontFamily: 'montserrat'),
          maxLines: 1,
          controller: widget.controller,
          decoration: InputDecoration(
              suffixIcon: widget.suffixIcon ?? const SizedBox(),
              label: Text(
                widget.label,
                style: TextStyle(color: AppColor.secondarySoft, fontSize: 14),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: TextStyle(
                  color: AppColor.secondarySoft,
                  fontSize: 14,
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
