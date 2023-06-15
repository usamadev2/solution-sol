import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solution_sol_task/screen/auth/sign_up/sign_up.dart';
import 'package:solution_sol_task/screen/home/home.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';

import '../../../../utils/widget/custom_button.dart';
import '../../../../utils/widget/custom_text.dart';
import '../../../utils/constant/color.dart';
import '../../../utils/widget/custom_text_field.dart';
import '../../../utils/widget/dialog.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              textEditingController: emailController,
            ),
            10.0.spaceY,
            CustomTextField(
              hintText: 'Password',
              textEditingController: passwordController,
            ),
            25.0.spaceY,
            CustomButton(
              onPressed: () {
                checkValues();
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

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } on FirebaseAuthException catch (ex) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show Alert Dialog
      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }
  }
}
