import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/view/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontSize: 22)),
        foregroundColor: Colors.white,
        // centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        actions: [Text("Total:30,000", style: TextStyle(fontSize: 18))],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 4, color: Colors.red[300]!),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text("Category: Food"),
                        Text("Amount: Rs.5000"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: CommonColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Text("Add"),
      ),
    );
  }
}
