import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/recipe.dart";
import "package:fp_recipe_book/ingredient.dart";

class NewRecipeModel extends ChangeNotifier {
  final List<Ingredient> ingredients = [];
  String recipeName = "";
  String directions = "";
  String description = "";

  void setRecipeName(String recipeName) {
    this.recipeName = recipeName;
    notifyListeners();
  }

  String getRecipeName() {
    return recipeName;
  }

  setDirections(String directions) {
    this.directions = directions;
    notifyListeners();
  }

  setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  setIngredients(List<Ingredient> ingredients) {
    this.ingredients.clear();
    for (Ingredient ingredient in ingredients) {
      this.ingredients.add(ingredient);
    }
    notifyListeners();
  }

  Recipe getNewRecipe() {
    return Recipe(recipeName, description, ingredients, directions, 1);
  }
}
