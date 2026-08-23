import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/controller/bottom_navbar_provider.dart';
import 'package:expense_tracker/features/dashboard/view/screens/add_expense_screen.dart';
import 'package:expense_tracker/features/dashboard/view/screens/dashbord_screen.dart';
import 'package:expense_tracker/features/dashboard/view/screens/history_screen.dart';
import 'package:expense_tracker/features/dashboard/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List screens = [DashbordScreen(), HistoryScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<BottomNavbarProvider>().selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.read<BottomNavbarProvider>().selectedIndex,
        onTap: (index) {
          context.read<BottomNavbarProvider>().updateSelectedIndex(index);
        },
        selectedItemColor: CommonColors.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
     
    );
  }
}
