// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screens/my_recipes.dart';
import 'package:uuid/uuid.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  var uuid = const Uuid();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController servingsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  bool _isLoading = false;
  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  Future<String?> _uploadImageToStorage() async {
    if (_image == null) return null;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('recipe_images')
        .child('${uuid.v4()}.jpg');

    await storageRef.putFile(_image!);
    return await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    final currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference myRecipesRef =
        userCollection.doc(currentUser!.email).collection("MyRecipes");

    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Recipe Title:",
                                style: TextStyle(
                                    fontFamily: "hellix", fontSize: 20),
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
                                  onTapOutside: (event) {
                                    print('onTapOutside');
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
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
                                style: TextStyle(
                                    fontFamily: "hellix", fontSize: 20),
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
                                  onTapOutside: (event) {
                                    print('onTapOutside');
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
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
                    ],
                  ),
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
                            onTapOutside: (event) {
                              print('onTapOutside');
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
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
                            onTapOutside: (event) {
                              print('onTapOutside');
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
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
                        left: 15, right: 15, top: 10, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add image:",
                          style: TextStyle(fontFamily: "hellix", fontSize: 20),
                        ),
                        InkWell(
                          onTap: _isPickingImage ? null : _pickImage,
                          child: Container(
                            width: 130,
                            height: 100,
                            decoration: BoxDecoration(
                              color: HexColor(backgroundColor),
                              borderRadius: BorderRadius.circular(14),
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _image == null
                                ? const Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  )
                                : null,
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
                        setState(() {
                          _isLoading = true;
                        });

                        String? imageUrl = await _uploadImageToStorage();

                        Recipe newRecipe = Recipe(
                            ingredients: ingredientsController.text,
                            instructions: instructionsController.text,
                            name: titleController.text,
                            servings: servingsController.text,
                            image: imageUrl ?? '',
                            recipeId: uuid.v4());

                        await myRecipesRef.doc().set(newRecipe.toMap());

                        setState(() {
                          _isLoading = false;
                        });

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
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Lottie.asset(
                    'lib/assets/animations/Animation - 1724239121865.json',
                    width: 400,
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
