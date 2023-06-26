import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../screen/auth/login/login.dart';
import '../screen/home/home.dart';
import '../utils/widget/dialog.dart';

class AuthProvider extends ChangeNotifier {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController fullNameController = TextEditingController();

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void logIn(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      UIHelper.showLoadingDialog(context, "Logging In..");
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
        clearController();
        log('login');
      } on FirebaseAuthException catch (ex) {
        // Close the loading dialog
        Navigator.pop(context);

        // Show Alert Dialog
        UIHelper.showAlertDialog(
            context, "An error occured", ex.message.toString());
      }
    }
  }

  Future signUp(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String userName = fullNameController.text.trim();
    UserCredential? credential;

    if (email == "" || password == "" || userName == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      UIHelper.showLoadingDialog(context, "Creating new account..");
      try {
        credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (ex) {
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
      log('signUp');
      clearController();
    }
  }

  Future logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
