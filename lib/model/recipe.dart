class Recipe {
  Recipe(
      {required this.ingredients,
      required this.instructions,
      required this.name,
      required this.servings,
      required this.image});
  final String name;
  final String ingredients;
  final String servings;
  final String instructions;
  final String image;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients,
      'servings': servings,
      'instructions': instructions,
      'image': image,
    };
  }
}
