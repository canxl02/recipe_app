import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screens/my_recipe_viewer.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({super.key});

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  @override
  Widget build(BuildContext context) {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference myRecipesRef =
        userCollection.doc(currentUser!.email).collection("MyRecipes");

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
      body: StreamBuilder<QuerySnapshot>(
        stream: myRecipesRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> listOfDocumentsSnap = asyncSnapshot.data.docs;
          return ListView.builder(
            itemCount: listOfDocumentsSnap.length,
            itemBuilder: (context, index) {
              var doc = listOfDocumentsSnap[index];
              Recipe recipe = Recipe(
                  name: doc["name"],
                  ingredients: doc["ingredients"],
                  servings: doc["servings"],
                  instructions: doc["instructions"],
                  image: doc["image"],
                  recipeId: doc["recipeId"]);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tileColor: HexColor(backgroundColor),
                    trailing: IconButton(
                      onPressed: () {
                        showAlertDialog(context, index, listOfDocumentsSnap);
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                    onTap: () {
                      Get.to(
                        () => const MyRecipeViewer(),
                        arguments: {"recipe": recipe},
                        transition: Transition.rightToLeft,
                      );
                    },
                    title: Text(recipe.name),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context, int index,
      List<DocumentSnapshot> listOfDocumentsSnap) {
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        listOfDocumentsSnap[index].reference.delete().then((_) {
          Navigator.pop(context);
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Recipe"),
      content: const Text("Are you sure you want to delete this recipe?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
