// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/common/common_colors.dart';
// import 'package:expense_tracker/features/dashboard/view/widgets/expense_textfield.dart';
// import 'package:flutter/material.dart';
// import 'dart:developer' as logger;

// class AddCategoryScreen extends StatefulWidget {
//   const AddCategoryScreen({super.key});

//   @override
//   State<AddCategoryScreen> createState() => _AddCategoryScreenState();
// }

// class _AddCategoryScreenState extends State<AddCategoryScreen> {
//   TextEditingController categoryController = TextEditingController();

//   @override
//   void dispose() {
//     categoryController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Add category")),

//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           spacing: 20,
//           children: [
//             ExpenseTextfield(
//               hintText: "category",
//               controller: categoryController,
//             ),

//             SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,

//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   backgroundColor: CommonColors.primaryColor,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () async {
//                   // logger.log("button pressed");
//                   try {
//                     await FirebaseFirestore.instance
//                         .collection('categories')
//                         .add({"username": "John", "userid": 1});

//                     logger.log("User added successfully");
//                   } catch (e) {
//                     logger.log(e.toString());
//                   }
//                 },
//                 child: Text("Add"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/common_colors.dart';
import 'package:expense_tracker/features/dashboard/view/widgets/expense_textfield.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as logger;

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add category")),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            ExpenseTextfield(
              hintText: "category",
              controller: categoryController,
            ),

            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: CommonColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // logger.log("button pressed");
                  try {
                    final snapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc('user1')
                        .get();
                     

                    logger.log("User added successfully");
                  } catch (e) {
                    logger.log(e.toString());
                  }
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
