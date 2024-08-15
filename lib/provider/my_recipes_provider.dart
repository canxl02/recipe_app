import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/model/recipe.dart';

class MyRecipesProvider extends ChangeNotifier {
  final List<Recipe> _myRecipes = [];
  List<Recipe> get myRecipes => _myRecipes;
  void addRecipe(Recipe recipe) {
    _myRecipes.add(recipe);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _myRecipes.remove(recipe);
    notifyListeners();
  }

  static MyRecipesProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<MyRecipesProvider>(context, listen: listen);
  }
}
