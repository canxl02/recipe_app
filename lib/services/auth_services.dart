// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String number,
  }) async {
    String res = "Some error Occurred";

    if (email.isNotEmpty ||
        password.isNotEmpty ||
        name.isNotEmpty ||
        number.isNotEmpty) {
      // register user in auth with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // add user to your  firestore database
      print(userCredential.user!.email);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'number': number,
        'name': name,
        'password': password,
        'email': email,
        "bio": "empty bio..."
      });

      res = "success";
    }

    return res;
  }
}
