import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solution_sol_task/controller/detail_provider.dart';
import 'package:solution_sol_task/models/detail_model.dart';
import 'package:solution_sol_task/utils/constant/color.dart';

import '../view/view_screen.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: true);

    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Collections')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DetailModel detailModel =
                      DetailModel.fromMap(snapshot.data!.docs[index].data());
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: AppColors.lightGreen),
                    child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewScreen(
                                  title: detailModel.title.toString(),
                                  author: detailModel.author.toString(),
                                  uid: detailModel.uid.toString(),
                                  image: detailModel.image.toString()))),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(detailModel.image!)),
                      title: Text(detailModel.title.toString()),
                      subtitle: Text(detailModel.author.toString()),
                      trailing: IconButton(
                          onPressed: () {
                            detailProvider.deleteDetails(detailModel.uid!);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
