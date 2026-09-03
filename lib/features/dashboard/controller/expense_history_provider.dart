import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class ExpenseHistoryProvider extends ChangeNotifier {
  List expenses = [];

  Future fetchExpenses() async {
    try {
      expenses = [];
      notifyListeners();
      final snapshot = await FirebaseFirestore.instance
          .collection('expenses')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (var doc in snapshot.docs) {
        expenses.add({
          'amount': doc.data()["amount"],
          'title': doc.data()["title"],
          'userId': doc.data()["userId"],
          'categoryName': doc.data()['categoryName'],
          'docId': doc.id,
        });
      }
      notifyListeners();
      logger.log(expenses.toString());
    } catch (e) {
      logger.log(e.toString());
    }
  }

  Map expenseWithDocid = {
    "categoryName": "unknown",
    "title": "unknown",
    "amount": "000",
  };

  Future fetchExpenseWithDocId(String docId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('expenses')
          .doc(docId)
          .get();

      expenseWithDocid = snapshot.data()!;
      logger.log(expenseWithDocid.toString());
    } catch (e) {
      logger.log(e.toString());
    }
  }
}
