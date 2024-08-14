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
  // ignore: non_constant_identifier_names
  final User = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  size: 95,
                  color: Colors.black87,
                ),
              ),
              MyListTitle(
                icon: Icons.favorite_outlined,
                text: "My Favourites",
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
