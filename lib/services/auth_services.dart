import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String number,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          number.isNotEmpty) {
        // register user in auth with email and password
        UserCredential cred =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // add user to your  firestore database
        print(cred.user!.email);
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(cred.user!.email)
            .set({
          'number': number,
          'name': name,
          'password': password,
          'email': email,
          "bio": "empty bio..."
        });

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
