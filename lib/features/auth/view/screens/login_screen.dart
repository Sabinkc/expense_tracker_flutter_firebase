import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/common/common_text_field.dart';
import 'package:expense_tracker/features/auth/view/screens/signup_screen.dart';
import 'package:expense_tracker/features/auth/view/widgets/common_button.dart';
import 'package:expense_tracker/features/dashboard/view/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: .center,
              spacing: 30,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 30,
                    fontWeight: .bold,
                  ),
                ),
                CommonTextField(hintText: "Email", controller: emailController),
                CommonTextField(
                  hintText: "Password",
                  controller: passwordController,
                ),
                CommonButton(
                  buttonName: "LOGIN",
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: CommonColors.primaryColor,
                          content: Text("Empty fields not allowed"),
                        ),
                      );
                      return;
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: CommonColors.primaryColor,
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: .center,
                  spacing: 3,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: CommonColors.primaryColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: CommonColors.primaryColor,
                          fontWeight: .w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
