import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/auth/view/screens/login_screen.dart';
import 'package:expense_tracker/features/dashboard/view/screens/add_category_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          spacing: 20,
                          mainAxisSize: .min,
                          children: [
                            Text("Are you sure you want to logout?"),
                            Row(
                              spacing: 40,
                              mainAxisAlignment: .spaceBetween,
                              mainAxisSize: .min,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: Text("Yes"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"),
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(left: BorderSide(color: Colors.red, width: 4)),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text("Logout"),
                    Icon(
                      Icons.logout_outlined,
                      color: CommonColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(left: BorderSide(color: Colors.red, width: 4)),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text("Add category"),
                    Icon(
                      Icons.category_outlined,
                      color: CommonColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
