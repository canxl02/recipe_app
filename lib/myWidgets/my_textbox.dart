import 'package:flutter/material.dart';

class MyTextbox extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String sectionName;

  const MyTextbox(
      {super.key,
      required this.sectionName,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.settings),
                color: Colors.grey[400],
              )
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
