import 'package:expense_tracker/common/common_colors.dart';
import 'package:flutter/material.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Center(child: Text("Dashboard Screen")),
    );
  }
}
