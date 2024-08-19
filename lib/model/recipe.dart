class Recipe {
  Recipe(
      {required this.ingredients,
      required this.instructions,
      required this.name,
      required this.servings,
      required this.image,
      required this.recipeId});
  final String name;
  final String ingredients;
  final String servings;
  final String instructions;
  final String image;
  final String recipeId;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients,
      'servings': servings,
      'instructions': instructions,
      'image': image,
      'recipeId': recipeId,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeId: map['recipeId'] ?? '',
      name: map['name'] ?? '',
      ingredients: map['ingredients'] ?? '',
      servings: map['servings'] ?? '',
      instructions: map['instructions'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
