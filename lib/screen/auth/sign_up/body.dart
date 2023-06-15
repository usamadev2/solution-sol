import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solution_sol_task/screen/auth/login/login.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';

import '../../../../utils/widget/custom_button.dart';
import '../../../../utils/widget/custom_text.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant/color.dart';
import '../../../utils/widget/custom_text_field.dart';
import '../../../utils/widget/dialog.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late TextEditingController fullNameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    fullNameController.dispose();
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
              textEditingController: fullNameController,
            ),
            8.0.spaceY,
            CustomTextField(
              hintText: 'Email addreess',
              textEditingController: emailController,
            ),
            8.0.spaceY,
            CustomTextField(
              hintText: 'Password',
              textEditingController: passwordController,
            ),
            16.0.spaceY,
            CustomButton(
              onPressed: () {
                checkValues();
              },
              text: 'Sign Up',
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

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String userName = fullNameController.text.trim();

    emailController.clear();
    passwordController.clear();
    fullNameController.clear();

    if (email == "" || password == "" || userName == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      signUp(email, password, userName);

      log('signUp');
    }
  }

  Future signUp(String email, String password, String userName) async {
    UserCredential? credential;
    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      if (!mounted) return;
      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        userName: userName,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LogInScreen();
              },
            ),
          );
        },
      );
    }
  }
}
