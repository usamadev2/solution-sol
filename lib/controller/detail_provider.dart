import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  getDetails() {}

  deleteDetails(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Collections')
        .doc(uid)
        .delete();
  }

  upDateDetails() {}

  addDetails() {}
}
