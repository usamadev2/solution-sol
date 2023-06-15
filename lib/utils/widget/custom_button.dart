import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/color.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.width,
    this.height,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textColor,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height ?? 50.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: backgroundColor ?? AppColors.lightGreen,
          border: Border.all(
            color: borderColor ?? AppColors.dividerColor,
            width: 0.2,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: shadowColor ?? AppColors.shadowlightGreen,
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: CustomText(
            text: text,
            style: TextStyle(
              fontFamily: 'ikka_rounded',
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: textColor ?? AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
