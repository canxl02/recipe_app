import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/myWidgets/loading_screen.dart';
import 'package:recipe_app/screens/bottom_navigation_bar.dart';
import 'package:recipe_app/screens/login_or_register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                const BottomnavigationBar(), // The target page
                FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(); // Empty container when the delay is over
                    } else {
                      return LoadingScreen(); // The transparent loading screen
                    }
                  },
                ),
              ],
            );
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
