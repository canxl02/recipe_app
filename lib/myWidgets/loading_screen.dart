import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'lib/assets/animations/Animation - 1724222422249.json',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
