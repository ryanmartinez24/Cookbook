import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipeParser.dart';

class Recipe {
  final String recipeName;
  final String description;
  List<Ingredient> ingredients;
  final String directions;

  Recipe(this.recipeName, this.description, this.ingredients, this.directions);
}
