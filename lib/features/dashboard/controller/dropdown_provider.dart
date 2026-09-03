import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class DropdownProvider extends ChangeNotifier {
  String? value;

  //value = Grocery

  //categories
  //test2category
  //test1category

  void updateValue(String? value) {
    this.value = value;
    notifyListeners();
  }

  void clearCategory() {
    value = null;
    notifyListeners();
  }

  List categories = [];

  Future fetchCategories() async {
    try {
      categories = [];
      value = null;
      notifyListeners();
      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (var doc in snapshot.docs) {
        categories.add(doc.data());
      }
      notifyListeners();
      logger.log(categories.toString());
    } catch (e) {
      logger.log(e.toString());
    }
  }
}
