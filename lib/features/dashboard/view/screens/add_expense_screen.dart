import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/common/common_text_field.dart';
import 'package:expense_tracker/features/dashboard/controller/dropdown_provider.dart';
import 'package:expense_tracker/features/dashboard/view/widgets/expense_textfield.dart';
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
                    value: provider.value,
                    // dropdownColor: Colors.red,
                    items: [
                      DropdownMenuItem(value: "food", child: Text("Food")),
                      DropdownMenuItem(
                        value: "clothes",
                        child: Text("Clothes"),
                      ),
                      DropdownMenuItem(
                        value: "grocery",
                        child: Text("Grocery"),
                      ),
                      DropdownMenuItem(
                        value: "transportation",
                        child: Text("Transportation"),
                      ),
                    ],
                    onChanged: (value) {
                      provider.updateValue(value);
                    },
                  );
                },
              ),
            ),
            ExpenseTextfield(hintText: "Amount", controller: amountController),
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
                onPressed: () {},
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
