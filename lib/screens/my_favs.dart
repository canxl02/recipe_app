import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';

import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/provider/favorite_provider.dart';
import 'package:recipe_app/screens/recipe_viewer.dart';

class MyFavs extends StatelessWidget {
  const MyFavs({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final finalList = provider.favorites;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Favourites",
          style: TextStyle(fontFamily: "hellix", color: Colors.black),
        ),
      ),
      body: MasonryView(
        listOfItem: finalList,
        numberOfColumn: 2,
        itemBuilder: (item) {
          Recipe recipe = item as Recipe;
          String imageName = recipe.image;
          return InkWell(
            onTap: () {
              Get.to(() => const RecipeViewer(),
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
