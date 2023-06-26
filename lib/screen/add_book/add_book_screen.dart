import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:solution_sol_task/main.dart';
import 'package:solution_sol_task/utils/constant/color.dart';
import 'package:solution_sol_task/utils/widget/extention.dart';

import '../../models/detail_model.dart';
import '../../utils/widget/custom_button.dart';
import '../../utils/widget/custom_text_field.dart';
import '../../utils/widget/dialog.dart';

class AddBookScreen extends StatefulWidget {
  final DetailModel? detailModel;
  const AddBookScreen({Key? key, this.detailModel}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  File? imageFile;
  late TextEditingController titleController;
  late TextEditingController authorController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    authorController = TextEditingController();

    authorController.text = widget.detailModel?.author ?? '';
    titleController.text = widget.detailModel?.title ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.splashBackground,
        title: const Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.0.spaceY,
              InkWell(
                onTap: () {
                  pickedImage();
                },
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundColor: AppColors.shadowlightGreen,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : widget.detailModel?.image != null
                          ? NetworkImage(widget.detailModel!.image!)
                              as ImageProvider<Object>
                          : null,
                ),
              ),
              10.0.spaceY,
              CustomTextField(
                hintText: 'Title',
                textEditingController: titleController,
              ),
              10.0.spaceY,
              CustomTextField(
                hintText: 'Author',
                textEditingController: authorController,
              ),
              25.0.spaceY,
              CustomButton(
                onPressed: () {
                  upLoading(context);
                },
                text: 'Add Detail',
                width: double.infinity,
                height: 50.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickedImage() async {
    XFile? imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      imageFile = File(imagePicker.path);
      setState(() {});
      log('selected image');
    } else {
      log('No Image selected');
    }
  }

  void upLoading(BuildContext context) async {
    String title = titleController.text.trim();
    String author = authorController.text.trim();

    if (title.isEmpty || author.isEmpty || imageFile == null) {
      UIHelper.showAlertDialog(context, '', 'Fill all the Field');
    } else {
      try {
        UIHelper.showLoadingDialog(context, "UpLoading..");

        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('ProfilePic')
            .child(uuid.v1())
            .putFile(imageFile!);

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        DetailModel detailModel = DetailModel(
          author: author,
          title: title,
          image: downloadUrl,
          uid: uuid.v1(),
        );
        if (widget.detailModel != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Collections')
              .doc(widget.detailModel!.uid)
              .update({'author': author, 'title': title, 'image': downloadUrl});
          if (!mounted) return;
          Navigator.pop(context);
          Navigator.pop(context);
          log('Update detail');
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Collections')
              .doc(detailModel.uid)
              .set(detailModel.toMap());
          if (!mounted) return;
          Navigator.pop(context);
          Navigator.pop(context);
          titleController.clear();
          authorController.clear();
          log('add detail');
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }
}
