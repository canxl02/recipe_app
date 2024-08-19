// ignore_for_file: annotate_overrides, avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/recipe.dart';

class RecipeViewer extends StatefulWidget {
  const RecipeViewer({super.key});

  @override
  State<RecipeViewer> createState() => _RecipeViewerState();
}

class _RecipeViewerState extends State<RecipeViewer> {
  late Recipe recipe;
  late bool isFavorite = false;

  @override
  void initState() {
    recipe = Get.arguments["recipe"];
    checkIfFavorite();
    super.initState();
  }

  Future<void> checkIfFavorite() async {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final currentUser = FirebaseAuth.instance.currentUser;
    final favRef =
        userCollection.doc(currentUser!.email).collection("Favorites");

    var querySnapshot =
        await favRef.where('recipeId', isEqualTo: recipe.recipeId).get();
    setState(() {
      isFavorite = querySnapshot.docs.isNotEmpty;
    });
  }

  Future<void> toggleFavorite() async {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final currentUser = FirebaseAuth.instance.currentUser;
    final favRef =
        userCollection.doc(currentUser!.email).collection("Favorites");

    if (isFavorite) {
      var doc =
          await favRef.where('recipeId', isEqualTo: recipe.recipeId).get();
      await doc.docs.first.reference.delete();
    } else {
      await favRef.add(recipe.toMap());
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, actions: [
        IconButton(
          onPressed: () {
            toggleFavorite();
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
