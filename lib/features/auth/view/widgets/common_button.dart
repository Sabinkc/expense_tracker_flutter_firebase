import 'package:expense_tracker/common/common_colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CommonButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: CommonColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(buttonName, style: TextStyle(fontWeight: .bold)),
      ),
    );
  }
}
