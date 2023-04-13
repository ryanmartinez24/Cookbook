import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/ingredient.dart";

class IngredientChangeNotifier extends ChangeNotifier {
  final List<Ingredient> ingredients = [];

  setIngredients(List<Ingredient> ingredients) {
    this.ingredients.clear();
    for (Ingredient ingredient in ingredients) {
      this.ingredients.add(ingredient);
    }
    notifyListeners();
  }

  List<Ingredient> getIngredients() {
    return [...ingredients];
  }
}
