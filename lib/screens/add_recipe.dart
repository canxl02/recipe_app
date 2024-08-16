import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/recipe.dart';

import 'package:recipe_app/screens/my_recipes.dart';
import 'package:uuid/uuid.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key /*, required this.addNewRecipe*/});
  /*final void Function(Recipe newRecipe) addNewRecipe;*/

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  String dropdownValue = "One";
  var uuid = Uuid();
  final _firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController servingsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference myRecipesRef = _firestore.collection("MyRecipes");

    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: deviceWidth,
                  height: deviceHeight / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Text(
                      "Add new recipe",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "hellix"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recipe Title:",
                          style: TextStyle(fontFamily: "hellix", fontSize: 20),
                        ),
                        Container(
                          width: deviceWidth / 2,
                          height: deviceHeight / 10,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: HexColor(backgroundColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Servings:",
                          style: TextStyle(fontFamily: "hellix", fontSize: 20),
                        ),
                        Container(
                          width: deviceWidth / 2,
                          height: deviceHeight / 10,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: HexColor(backgroundColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            controller: servingsController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, top: 8, bottom: 8, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ingredients:",
                      style: TextStyle(fontFamily: "hellix", fontSize: 20),
                    ),
                    Container(
                      width: deviceWidth,
                      height: deviceHeight / 10,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: HexColor(backgroundColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: ingredientsController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Instructions:",
                      style: TextStyle(fontFamily: "hellix", fontSize: 20),
                    ),
                    Container(
                      height: deviceHeight / 4,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: HexColor(backgroundColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: instructionsController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: HexColor(backgroundColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: DropdownButton<String>(
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        value: dropdownValue,
                        items: const [
                          DropdownMenuItem<String>(
                              child: Text("Choose Image"), value: "One"),
                          DropdownMenuItem<String>(
                              child: Text("One"),
                              value: "lib/assets/images/image_m.jpg"),
                          DropdownMenuItem<String>(
                              child: Text("Two"),
                              value: "lib/assets/images/image11.jpeg"),
                          DropdownMenuItem<String>(
                              child: Text("Three"),
                              value: "lib/assets/images/image10.jpeg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(myGreen)),
                  onPressed: () async {
                    Recipe newRecipe = Recipe(
                        ingredients: ingredientsController.text,
                        instructions: instructionsController.text,
                        name: titleController.text,
                        servings: servingsController.text,
                        image: dropdownValue);

                    await myRecipesRef.doc(uuid.v4()).set(newRecipe.toMap());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyRecipes()));
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*DropdownButton<String>(
                          value: dropdownValue,
                          items: const [
                            DropdownMenuItem<String>(
                                child: Text("Choose Image"), value: "One"),
                            DropdownMenuItem<String>(
                                child: Text("One"),
                                value: "lib/assets/images/image_m.jpg"),
                            DropdownMenuItem<String>(
                                child: Text("Two"),
                                value: "lib/assets/images/image11.jpeg"),
                            DropdownMenuItem<String>(
                                child: Text("Three"),
                                value: "lib/assets/images/image10.jpeg"),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          }),*/