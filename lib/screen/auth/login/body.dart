import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:solution_sol_task/controller/auth_provider.dart';
import 'package:solution_sol_task/screen/auth/sign_up/sign_up.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';

import '../../../../utils/widget/custom_button.dart';
import '../../../../utils/widget/custom_text.dart';
import '../../../utils/constant/color.dart';
import '../../../utils/widget/custom_text_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
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
            120.0.spaceY,
            CustomText(
              text: 'Login Account',
              style: TextStyle(
                fontFamily: 'ikka_rounded',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.splashBackground,
              ),
            ),
            24.0.spaceY,
            CustomTextField(
              hintText: 'Email address',
              textEditingController: authProvider.emailController,
            ),
            10.0.spaceY,
            CustomTextField(
              hintText: 'Password',
              textEditingController: authProvider.passwordController,
            ),
            25.0.spaceY,
            CustomButton(
              onPressed: () {
                authProvider.logIn(context);
              },
              text: 'LoG in',
              width: double.infinity,
              height: 50.sp,
            ),
            16.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Don't have an account?",
                  color: AppColors.textColor2,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpScreen();
                        },
                      ),
                    );
                  },
                  text: ' Sign Up',
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
