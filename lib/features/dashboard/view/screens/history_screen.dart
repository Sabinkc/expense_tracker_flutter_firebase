import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/controller/expense_history_provider.dart';
import 'package:expense_tracker/features/dashboard/view/screens/edit_expense_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseHistoryProvider>().fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense History"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Consumer<ExpenseHistoryProvider>(
        builder: (context, provider, child) {
          return provider.expenses.isEmpty
              ? Center(child: Text("No expenses till now"))
              : ListView.builder(
                  itemCount: provider.expenses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.red, width: 4),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  "Category: ${provider.expenses[index]["categoryName"]}",
                                ),
                                Text(
                                  "Amount:${provider.expenses[index]["amount"]}",
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  "Title: ${provider.expenses[index]["title"]}",
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditExpenseScreen(
                                                  docId: provider
                                                      .expenses[index]['docId'],
                                                ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.blue[200],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('expenses')
                                            .doc(
                                              provider.expenses[index]["docId"],
                                            )
                                            .delete();
                                        await context
                                            .read<ExpenseHistoryProvider>()
                                            .fetchExpenses();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                CommonColors.primaryColor,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Expense deleted successfully",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red[200],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
