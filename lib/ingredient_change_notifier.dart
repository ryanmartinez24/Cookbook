import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/ingredient.dart";

class IngredientChangeNotifier extends ChangeNotifier {
  final List<Ingredient> _ingredients = [];

  setIngredients(List<Ingredient> newIngredients) {
    _ingredients.clear();
    for (Ingredient ingredient in newIngredients) {
      _ingredients.add(ingredient.getCopy());
    }
    notifyListeners();
  }

  addIngredient(Ingredient newIngredient) {
    _ingredients.add(newIngredient);
  }

  //Return a deep copy of the private ingredients list
  List<Ingredient> getIngredients() {
    List<Ingredient> returnIngredients = [];
    for (Ingredient ingredient in _ingredients) {
      returnIngredients.add(ingredient.getCopy());
    }
    return returnIngredients;
  }
}
