import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  final String recipeName;
  final String description;
  List<Ingredient> ingredients;
  final String directions;
  double scale;

  Recipe(this.recipeName, this.description, this.ingredients, this.directions,
      this.scale);

  Recipe.fromJson(Map<String, dynamic> json)
      : recipeName = json['recipeName'],
        description = json['description'],
        ingredients = json['ingredients'],
        directions = json['directions'],
        scale = json['scale'];

  Map<String, dynamic> toJson() => {
        'recipeName': recipeName,
        'description': description,
        'ingredients': ingredients,
        'directions': directions,
        'scale': scale
      };

  void scaleIngredients(double servings) {
    for (Ingredient ingredient in ingredients) {
      ingredient.measurement.scale(servings);
    }
  }
}
