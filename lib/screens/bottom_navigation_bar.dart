import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/recipe.dart';

import 'package:recipe_app/screens/add_recipe.dart';
import 'package:recipe_app/screens/user.dart';
import 'package:recipe_app/screens/home_screen.dart';
//import 'package:recipe_app/screens/user_screen.dart';

class BottomnavigationBar extends StatefulWidget {
  const BottomnavigationBar({super.key});

  @override
  State<BottomnavigationBar> createState() => _BottomnavigationBarState();
}

class _BottomnavigationBarState extends State<BottomnavigationBar> {
  late List<Widget> myScreens;
  late Homescreen homeScreen;
  late AddRecipe addRecipe;
  late MyUser userScreen;

  //late UserScreen userScreen;

  int _selectedIndex = 0;

  /* void addNewRecipe(Recipe newRecipe) {
    setState(() {
      recipeList.add(newRecipe);
    });
  */

  @override
  void initState() {
    super.initState();
    homeScreen = const Homescreen();
    addRecipe = AddRecipe(
        /* addNewRecipe: (newRecipe) => addNewRecipe(newRecipe),*/
        );
    userScreen = const MyUser();

    myScreens = [homeScreen, addRecipe, userScreen];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // ignore: avoid_print
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor(backgroundColor),
        currentIndex: _selectedIndex,
        iconSize: 30,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined),
            label: 'Add Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
      ),
      body: myScreens[_selectedIndex],
    );
  }
}
