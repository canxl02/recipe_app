import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/provider/my_recipes_provider.dart';
import 'package:recipe_app/screens/my_recipe_viewer.dart';
import 'package:recipe_app/screens/recipe_viewer.dart';

class MyRecipes extends StatelessWidget {
  const MyRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = MyRecipesProvider.of(context);
    final finalListt = provider.myRecipes;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Recipes",
          style: TextStyle(fontFamily: "hellix", color: Colors.black),
        ),
      ),
      body: MasonryView(
        listOfItem: finalListt,
        numberOfColumn: 2,
        itemBuilder: (item) {
          Recipe recipe = item as Recipe;
          String imageName = recipe.image;
          return InkWell(
            onTap: () {
              Get.to(() => const MyRecipeViewer(),
                  transition: Transition.rightToLeft,
                  arguments: {"recipe": recipe});
            },
            child: Image.asset(imageName),
          );
        },
      ),
    );
  }
}
