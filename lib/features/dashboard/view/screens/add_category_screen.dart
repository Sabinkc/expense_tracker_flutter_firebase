// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/view/widgets/expense_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add category")),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            ExpenseTextfield(
              hintText: "category",
              controller: categoryController,
            ),

            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: CommonColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  String category = categoryController.text;

                  if (category.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: CommonColors.primaryColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Category must not be empty"),
                      ),
                    );
                    return;
                  }
                  try {
                    final User? currentUser = FirebaseAuth.instance.currentUser;

                    await FirebaseFirestore.instance
                        .collection('categories')
                        .add({
                          "categoryName": category,
                          "userId": currentUser!.uid,
                        });
                    categoryController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: CommonColors.primaryColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Category added successfully"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: CommonColors.primaryColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
