import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';

import '../../../../utils/widget/custom_button.dart';
import '../../../../utils/widget/custom_text.dart';
import '../../../controller/auth_provider.dart';
import '../../../utils/constant/color.dart';
import '../../../utils/widget/custom_text_field.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            150.0.spaceY,
            CustomText(
              text: 'Create an account',
              style: TextStyle(
                fontFamily: 'ikka_rounded',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.splashBackground,
              ),
            ),
            16.0.spaceY,
            CustomTextField(
              hintText: 'Full name',
              textEditingController: authProvider.fullNameController,
            ),
            8.0.spaceY,
            CustomTextField(
              hintText: 'Email addreess',
              textEditingController: authProvider.emailController,
            ),
            8.0.spaceY,
            CustomTextField(
              hintText: 'Password',
              textEditingController: authProvider.passwordController,
            ),
            16.0.spaceY,
            CustomButton(
              onPressed: () {
                authProvider.signUp(context);
              },
              text: 'Sign Up',
              width: double.infinity,
              height: 50.sp,
            ),
            16.0.spaceY,
            CustomButton(
              onPressed: () {
                authProvider.googleLogin(context);
              },
              text: 'GoogleLogin',
              width: double.infinity,
              height: 50.sp,
            ),
            16.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Already have an account? ',
                  color: AppColors.textColor2,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Log in',
                  color: AppColors.lightGreen,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
