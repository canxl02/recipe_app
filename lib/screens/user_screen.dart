import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/myWidgets/my_textbox.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[700],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
    if (newValue.trim().length > 0) {
      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Profile Page",
            style: TextStyle(fontFamily: "Hellix"),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: userCollection.doc(currentUser!.email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Check if document exists
              if (!snapshot.data!.exists) {
                return Center(
                  child: Text("User data does not exist."),
                );
              }

              // Safely cast data to Map<String, dynamic>
              final userData = snapshot.data!.data() as Map<String, dynamic>?;
              print(userData);
              // If userData is null, handle the case
              if (userData == null) {
                return Center(
                  child: Text("No user data available."),
                );
              }

              // Proceed with displaying user data
              return ListView(
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.person, size: 92),
                  const SizedBox(height: 10),
                  Text(
                    currentUser!.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "hellix",
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "My Details",
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
                  ),
                  MyTextbox(
                    sectionName: "username",
                    text: userData["name"] ?? "No name provided",
                    onPressed: () => editField("name"),
                  ),
                  MyTextbox(
                    sectionName: "phone number",
                    text: userData["number"] ?? "No number provided",
                    onPressed: () => editField("number"),
                  ),
                  MyTextbox(
                    sectionName: "bio",
                    text: userData["bio"] ?? "No bio provided",
                    onPressed: () => editField("bio"),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
