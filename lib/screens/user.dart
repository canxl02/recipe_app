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
                    const SizedBox(height: 10),
                    Text(
                      User!.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "hellix",
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    ),
                  ],
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
