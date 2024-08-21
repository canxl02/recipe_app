import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/recipe.dart';

import 'package:recipe_app/screens/recipe_viewer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "What would you like to cook today?",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: "hellixB",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: HexColor(backgroundColor),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  onTapOutside: (event) {
                    print('onTapOutside');
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: searchController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 34,
                    ),
                    hintText: "Search for recipes",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("Recipes").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> documents = snapshot.data!.docs;

                  String searchQuery = searchController.text.toLowerCase();
                  List<Recipe> recipeList = documents.map((doc) {
                    return Recipe(
                        name: doc["name"],
                        ingredients: doc["ingredients"],
                        instructions: doc["instructions"],
                        servings: doc["servings"],
                        image: doc["image"],
                        recipeId: doc["recipeId"]);
                  }).where((recipe) {
                    return recipe.name.toLowerCase().contains(searchQuery);
                  }).toList();

                  return MasonryView(
                    listOfItem: recipeList,
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
