import 'package:flutter/material.dart';

import '../../utils/constant/color.dart';
import 'body.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.splashBackground,
        title: const Text('Add Book'),
      ),
      body: const AddBookBody(),
    );
  }
}
