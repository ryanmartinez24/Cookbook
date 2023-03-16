import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  final String recipeName;
  final String description;
  List<Ingredient> ingredients;
  final String directions;
  double scale;

  Recipe(this.recipeName, this.description, this.ingredients, this.directions,
      this.scale);
}
