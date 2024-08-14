// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screens/my_favs.dart';

class RecipeViewer extends StatefulWidget {
  const RecipeViewer({super.key});

  @override
  State<RecipeViewer> createState() => _RecipeViewerState();
}

class _RecipeViewerState extends State<RecipeViewer> {
  bool isFavorite = false;

  late Recipe recipe;
  @override
  void initState() {
    recipe = Get.arguments["recipe"];
    print(recipe.ingredients);
    super.initState();
  }

  /* List<Recipe> favList = [];

  void addToFav(Recipe recipe) {
    setState(() {
      favList.add(recipe);
    });}
   
     void removeFromFav(Recipe recipe) {
    setState(() {
      favList.remove(recipe);
    });}
    
     */

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
              if (isFavorite) {
                // Add to favorites list
                /*  Get.to(()=>MyFavs() ,arguments: {"recipe": recipe});
            addToFav(Recipe(
                ingredients: recipe.ingredients,
                instructions: recipe.instructions,
                name: recipe.name,
                servings: recipe.servings,
                image: recipe.image) );*/
              } else {
                // Remove from favorites list
                /* Get.to(()=>MyFavs() ,arguments: {"recipe": recipe});
            removeFromFav(Recipe(
                ingredients: recipe.ingredients,
                instructions: recipe.instructions,
                name: recipe.name,
                servings: recipe.servings,
                image: recipe.image) ); */
              }
            });
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFavorite ? Colors.red : null,
            size: 30,
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 260,
                  width: 400,
                  decoration: BoxDecoration(
                    color: HexColor(backgroundColor),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    recipe.name,
                    style: TextStyle(
                        fontFamily: "hellixB",
                        fontSize: 15,
                        color: Colors.amber[800]),
                  ),
                  const SizedBox(height: 20),
                  const Text("Ingredients: ",
                      style: TextStyle(fontFamily: "hellixB")),
                  Text(recipe.ingredients),
                  const SizedBox(height: 10),
                  const Text("Servings: ",
                      style: TextStyle(fontFamily: "hellixB")),
                  Text(recipe.servings),
                  const SizedBox(height: 10),
                  const Text("Instructions: ",
                      style: TextStyle(fontFamily: "hellixB")),
                  Text(recipe.instructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
