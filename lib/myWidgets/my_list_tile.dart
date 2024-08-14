import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';

class MyListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MyListTitle({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        tileColor: HexColor(backgroundColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Icon(
          icon,
          color: Colors.black87,
          size: 35,
        ),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(
              color: Colors.black54, fontFamily: "hellix", fontSize: 22),
        ),
      ),
    );
  }
}
