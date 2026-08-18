import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/common/common_text_field.dart';
import 'package:expense_tracker/features/auth/view/screens/login_screen.dart';
import 'package:expense_tracker/features/auth/view/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  "Signup",
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
                CommonTextField(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                ),
                CommonButton(
                  buttonName: "SIGNUP",
                  onPressed: () {
                    logger.log("button pressed");
                  },
                ),
                Row(
                  mainAxisAlignment: .center,
                  spacing: 3,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: CommonColors.primaryColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
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
