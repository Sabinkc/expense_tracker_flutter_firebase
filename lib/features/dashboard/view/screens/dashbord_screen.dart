import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/controller/expense_history_provider.dart';
import 'package:expense_tracker/features/dashboard/view/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as logger;

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ExpenseHistoryProvider>().fetchExpenses();
      // logger.log(
      //   context.read<ExpenseHistoryProvider>().getTotalAmount().toString(),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontSize: 22)),
        foregroundColor: Colors.white,
        // centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        actions: [
          Consumer<ExpenseHistoryProvider>(
            builder: (context, provider, child) {
              return Text(
                "Total:${provider.getTotalAmount()}",
                style: TextStyle(fontSize: 18),
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      body: Consumer<ExpenseHistoryProvider>(
        builder: (context, provider, child) {
          return provider.expenses.isEmpty
              ? Center(child: Text("No expenses till now"))
              : ListView.builder(
                  itemCount: provider.getCategoryTotal().length,
                  itemBuilder: (context, index) {
                    Map<String, num> categoryAmount = provider
                        .getCategoryTotal();

                    String category = categoryAmount.keys.elementAt(index);
                    num amount = categoryAmount[category]!;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 4,
                              color: Colors.red[300]!,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text("Category: $category"),
                            Text("Amount: Rs.$amount"),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
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
