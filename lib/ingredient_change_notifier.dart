import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/ingredient.dart";

class IngredientChangeNotifier extends ChangeNotifier {
  final List<Ingredient> _ingredients = [];

  setIngredients(List<Ingredient> newIngredients) {
    _ingredients.clear();
    for (Ingredient ingredient in newIngredients) {
      _ingredients.add(ingredient);
    }
    notifyListeners();
  }

  List<Ingredient> getIngredients() {
    return [..._ingredients];
  }
}
