// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      // Ensures the background is fully transparent
      child: Center(
        child: Lottie.asset(
          'lib/assets/animations/Animation - 1724222422249.json',
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
