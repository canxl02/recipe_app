import 'package:flutter/material.dart';

class MyRecipes extends StatelessWidget {
  const MyRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Recipes",
          style: TextStyle(fontFamily: "hellix", color: Colors.black),
        ),
      ),
    );
  }
}
