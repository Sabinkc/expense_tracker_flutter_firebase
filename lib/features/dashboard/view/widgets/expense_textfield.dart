import 'package:expense_tracker/common/common_colors.dart';
import 'package:flutter/material.dart';

class ExpenseTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const ExpenseTextfield({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CommonColors.primaryColor),
        ),
      ),
    );
  }
}
