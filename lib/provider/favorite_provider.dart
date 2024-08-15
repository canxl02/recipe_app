import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/model/recipe.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Recipe> _favorite = [];
  List<Recipe> get favorites => _favorite;
  void toggleFavorite(Recipe recipe) {
    if (_favorite.contains(recipe)) {
      _favorite.remove(recipe);
    } else {
      _favorite.add(recipe);
    }
    notifyListeners();
  }

  bool isExist(Recipe recipe) {
    final isExist = _favorite.contains(recipe);
    return isExist;
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
