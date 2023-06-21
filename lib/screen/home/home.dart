import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_sol_task/screen/auth/login/login.dart';

import '../../utils/constant/color.dart';
import '../add_book/add_book_screen.dart';
import 'body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.splashBackground,
          title: const Text('Collections'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogInScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout))
          ]),
      body: const HomeScreenBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddBookScreen();
              },
            ));
          },
          backgroundColor: AppColors.shadowlightGreen,
          child: const Icon(Icons.add)),
    );
  }
}
