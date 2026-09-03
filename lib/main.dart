import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/auth/view/screens/login_screen.dart';
import 'package:expense_tracker/features/dashboard/controller/bottom_navbar_provider.dart';
import 'package:expense_tracker/features/dashboard/controller/dropdown_provider.dart';
import 'package:expense_tracker/features/dashboard/controller/expense_history_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (context) => DropdownProvider()),
        ChangeNotifierProvider(create: (context) => ExpenseHistoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: CommonColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.green[50],
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
