// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screens/recipe_viewer.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
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
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase(); // Convert query to lowercase
            });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: (_searchQuery.isEmpty)
                ? FirebaseFirestore.instance.collection('Recipes').snapshots()
                : FirebaseFirestore.instance
                    .collection('Recipes')
                    .where('name', isGreaterThanOrEqualTo: _searchQuery)
                    .where('name', isLessThanOrEqualTo: '$_searchQuery\uf8ff')
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final documents = snapshot.data!.docs;
                List<Recipe> recipeList = documents.map((doc) {
                  return Recipe(
                    name: doc["name"],
                    ingredients: doc["ingredients"],
                    instructions: doc["instructions"],
                    servings: doc["servings"],
                    image: doc["image"],
                    recipeId: doc["recipeId"],
                  );
                }).toList();
                return ListView.builder(
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = recipeList[index];
                    return MasonryView(
                      listOfItem: [recipe],
                      numberOfColumn: 2,
                      itemBuilder: (item) {
                        Recipe recipeItem = item as Recipe;
                        return InkWell(
                          onTap: () {
                            Get.to(() => const RecipeViewer(),
                                transition: Transition.rightToLeft,
                                arguments: {"recipe": recipeItem});
                          },
                          child: Image.asset(recipeItem.image),
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
