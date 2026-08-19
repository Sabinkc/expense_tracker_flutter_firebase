import 'package:expense_tracker/common/common_colors.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Center(child: Text("History screen")),
    );
  }
}
