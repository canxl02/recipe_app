// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/myWidgets/my_list_tile.dart';
import 'package:recipe_app/screens/my_favs.dart';
import 'package:recipe_app/screens/my_recipes.dart';
import 'package:recipe_app/screens/user_screen.dart';

class MyUser extends StatefulWidget {
  const MyUser({
    super.key,
  });

  @override
  State<MyUser> createState() => _MyUserState();
}

class _MyUserState extends State<MyUser> {
  final User = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 95,
                      color: Colors.black87,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: userCollection.doc(User!.email).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (!snapshot.data!.exists) {
                              return const Center(
                                child: Text("User data does not exist."),
                              );
                            }

                            final userData =
                                snapshot.data!.data() as Map<String, dynamic>?;
                            if (userData == null) {
                              return const Center(
                                child: Text("No user data available."),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child:
                                  Center(child: Text("#" + userData["name"])),
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ],
                ),
              ),
              MyListTitle(
                icon: Icons.favorite_outlined,
                text: "My Favorites",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyFavs())),
              ),
              MyListTitle(
                icon: Icons.sticky_note_2_sharp,
                text: "My Recipes",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyRecipes())),
              ),
              MyListTitle(
                icon: Icons.account_circle_sharp,
                text: "My Profile",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserScreen())),
              ),
              /*  MyListTitle(
                icon: Icons.mode_night_outlined,
                text: "Dark Mode",
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ), */
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MyListTitle(
              icon: Icons.logout,
              text: "Log Out",
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
