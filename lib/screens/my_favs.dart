import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screens/recipe_viewer.dart';

class MyFavs extends StatelessWidget {
  const MyFavs({super.key});

  @override
  Widget build(BuildContext context) {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final currentUser = FirebaseAuth.instance.currentUser;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: userCollection
            .doc(currentUser!.email)
            .collection("Favorites")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No favorites yet!",
                style: TextStyle(fontFamily: "hellix", fontSize: 18),
              ),
            );
          }

          final favoriteRecipes = snapshot.data!.docs.map((doc) {
            return Recipe.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return MasonryView(
            listOfItem: favoriteRecipes,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(imageName),
                    const SizedBox(height: 5),
                    Text(
                      recipe.name,
                      style: const TextStyle(
                          fontFamily: "hellix", color: Colors.black87),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
