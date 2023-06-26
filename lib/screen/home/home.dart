import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_provider.dart';
import '../../utils/constant/color.dart';
import '../add_book/add_book_screen.dart';
import 'body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.splashBackground,
          title: const Text('Collections'),
          actions: [
            IconButton(
                onPressed: () {
                  authProvider.logOut(context);
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
