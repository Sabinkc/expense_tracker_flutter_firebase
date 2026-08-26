import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class DropdownProvider extends ChangeNotifier {
  String? value;

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
      notifyListeners();
      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
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
