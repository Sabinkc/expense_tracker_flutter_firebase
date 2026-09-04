import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/common/common_text_field.dart';
import 'package:expense_tracker/features/dashboard/controller/dropdown_provider.dart';
import 'package:expense_tracker/features/dashboard/controller/expense_history_provider.dart';
import 'package:expense_tracker/features/dashboard/view/widgets/expense_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DropdownProvider>().fetchCategories();
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add expenses")),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              width: double.infinity,
              child: Consumer<DropdownProvider>(
                builder: (context, provider, child) {
                  return DropdownButton(
                    isExpanded: true,
                    underline: SizedBox(),
                    // focusColor: Colors.white,
                    iconEnabledColor: Colors.red,
                    hint: Text("Choose a category"),
                    value: provider.value, //null
                    // dropdownColor: Colors.red,
                    items: List.generate(provider.categories.length, (index) {
                      return DropdownMenuItem(
                        value: provider
                            .categories[index]["categoryName"], //test1categoy, test2category
                        child: Text(provider.categories[index]["categoryName"]),
                      );
                    }),

                    // items: List.generate(provider.categories.length, (index) {
                    //   return DropdownMenuItem(
                    //     value: provider.categories[index]["categoryName"],
                    //     child: Text(provider.categories[index]["categoryName"]),
                    //   );
                    // }),
                    onChanged: (value) {
                      provider.updateValue(value.toString());
                    },
                  );
                },
              ),
            ),
            ExpenseTextfield(
              hintText: "Amount",
              controller: amountController,
              inputType: TextInputType.number,
            ),
            ExpenseTextfield(hintText: "Title", controller: titleController),
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
                  String? category = context.read<DropdownProvider>().value;
                  String amount = amountController.text;
                  String title = titleController.text;

                  if (category == null ||
                      amount.trim().isEmpty ||
                      title.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: CommonColors.primaryColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text("All fields must be provided"),
                      ),
                    );
                    return;
                  }

                  try {
                    await FirebaseFirestore.instance
                        .collection('expenses')
                        .add({
                          "categoryName": category,
                          "amount": int.parse(amount),
                          "title": title,
                          "userId": FirebaseAuth.instance.currentUser!.uid,
                        });
                    await context
                        .read<ExpenseHistoryProvider>()
                        .fetchExpenses();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: CommonColors.primaryColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Expense added successfully"),
                      ),
                    );
                    context.read<DropdownProvider>().clearCategory();
                    amountController.clear();
                    titleController.clear();
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
