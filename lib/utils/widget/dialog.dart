import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';
import '../constant/color.dart';
import 'custom_text.dart';

class UIHelper {
  static void showLoadingDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      content: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppColors.black,
            ),
            const SizedBox(
              height: 30,
            ),
            10.0.spaceY,
            CustomText(
              text: title,
              textAlign: TextAlign.center,
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return loadingDialog;
        });
  }

  static void showForrgotPasswordDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: AppColors.splashBackground,
      content: Container(
        color: AppColors.splashBackground,
        padding: const EdgeInsets.all(20),
        height: 200.sp,
        width: 338.sp,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(r'assets/icons/email.png'),
            const SizedBox(
              height: 30,
            ),
            CustomText(
              text: title,
              textAlign: TextAlign.center,
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return loadingDialog;
        });
  }

  static void showAlertDialog(
      BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      title: CustomText(
        text: title,
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      content: CustomText(
        text: content,
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Ok"),
        ),
      ],
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alertDialog;
        });
  }
}
