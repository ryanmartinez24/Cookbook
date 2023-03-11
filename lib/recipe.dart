import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  final String recipeName;
  final String description;
  final List<Ingredient> ingredients;
  final String directions;

  Recipe(this.recipeName, this.description, this.ingredients, this.directions);
}
