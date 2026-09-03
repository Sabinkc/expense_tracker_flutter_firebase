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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ExpenseHistoryProvider>().fetchExpenseWithDocId(widget.docId);
    final TextEditingController categoryController = TextEditingController(
      text: context
          .read<ExpenseHistoryProvider>()
          .expenseWithDocid["categoryName"],
    );
    final TextEditingController amountController = TextEditingController(
      text: context.read<ExpenseHistoryProvider>().expenseWithDocid['amount'],
    );
    final TextEditingController titleController = TextEditingController(
      text: context.read<ExpenseHistoryProvider>().expenseWithDocid["title"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("EditExpense")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            ExpenseTextfield(
              hintText: "Edit your category",
              controller: categoryController,
            ),
            ExpenseTextfield(
              hintText: "Edit your amount",
              controller: amountController,
            ),
            ExpenseTextfield(
              hintText: "Edit your title",
              controller: titleController,
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
                onPressed: () {},
                child: Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
