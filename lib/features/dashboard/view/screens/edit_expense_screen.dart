import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/controller/expense_history_provider.dart';
import 'package:expense_tracker/features/dashboard/view/widgets/expense_textfield.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

import 'package:provider/provider.dart';

class EditExpenseScreen extends StatefulWidget {
  final String docId;
  const EditExpenseScreen({super.key, required this.docId});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  TextEditingController? categoryController;
  TextEditingController? amountController;
  TextEditingController? titleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ExpenseHistoryProvider>().fetchExpenseWithDocId(
        widget.docId,
      );
      categoryController = TextEditingController(
        text: context
            .read<ExpenseHistoryProvider>()
            .expenseWithDocid["categoryName"],
      );
      amountController = TextEditingController(
        text: context
            .read<ExpenseHistoryProvider>()
            .expenseWithDocid['amount']
            .toString(),
      );
      titleController = TextEditingController(
        text: context.read<ExpenseHistoryProvider>().expenseWithDocid["title"],
      );
      setState(() {});
      logger.log(
        "category: ${categoryController!.text},amount:${amountController!.text}, title:${titleController!.text}",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("EditExpense")),
      body:
          (categoryController == null ||
              amountController == null ||
              titleController == null)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                spacing: 20,
                children: [
                  ExpenseTextfield(
                    hintText: "Edit your category",
                    controller: categoryController!,
                  ),
                  ExpenseTextfield(
                    inputType: TextInputType.number,
                    hintText: "Edit your amount",
                    controller: amountController!,
                  ),
                  ExpenseTextfield(
                    hintText: "Edit your title",
                    controller: titleController!,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        try {
                          await FirebaseFirestore.instance
                              .collection('expenses')
                              .doc(widget.docId)
                              .update({
                                'amount': int.parse(amountController!.text),
                                'title': titleController!.text,
                                'categoryName': categoryController!.text,
                              });
                          await context
                              .read<ExpenseHistoryProvider>()
                              .fetchExpenses();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: CommonColors.primaryColor,
                              content: Text("Expenses edited successfully"),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: CommonColors.primaryColor,
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: Text("Edit"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
