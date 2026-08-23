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
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.red, width: 4)),
                color: Colors.white,
              ),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [Text("Category: Food"), Text("Amount:300")],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text("Title: Lunch"),
                      Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.edit_outlined, color: Colors.blue[200]),
                          Icon(Icons.delete_outline, color: Colors.red[200]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
