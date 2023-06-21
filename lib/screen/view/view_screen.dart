// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:solution_sol_task/models/detail_model.dart';
import 'package:solution_sol_task/screen/add_book/add_book_screen.dart';
import 'package:solution_sol_task/utils/widget/custom_text.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';

import '../../utils/constant/color.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen(
      {Key? key,
      required this.title,
      required this.author,
      required this.image,
      required this.uid})
      : super(key: key);

  final String title;
  final String author;
  final String image;
  final String uid;

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.splashBackground,
        title: const Text('View Book'),
        actions: [
          Center(
            child: CustomText(
              text: 'Update',
              fontSize: 16.0,
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookScreen(
                    detailModel: DetailModel(
                        author: widget.author,
                        title: widget.title,
                        image: widget.image,
                        uid: widget.uid),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              16.0.spaceY,
              CustomText(text: 'Name: ${widget.title}', fontSize: 24.0),
              const Divider(
                  color: AppColors.black,
                  thickness: 2,
                  indent: 50,
                  endIndent: 40),
              16.0.spaceY,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.amber),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              16.0.spaceY,
              CustomText(text: 'Author: ${widget.author}', fontSize: 16.0),
              24.0.spaceY,
            ],
          ),
        ),
      ),
    );
  }
}
