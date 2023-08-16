import 'package:flutter/material.dart';
import 'package:flutter_application_7hive_first/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onsave;
  const DialogBox({super.key, required this.controller, required this.onsave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Mybutton(text: 'Save', onPressed: onsave),
                const SizedBox(
                  width: 10,
                ),
                Mybutton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
