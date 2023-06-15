import 'package:flutter/material.dart';
import 'package:solution_sol_task/screen/auth/login/body.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody(),
    );
  }
}
