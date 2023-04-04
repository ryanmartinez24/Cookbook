import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/recipe.dart";

class RecipesModel extends ChangeNotifier {
  final Map<String, Recipe> recipeMap = {};

  void addRecipe(String recipeName, Recipe recipe) {
    recipeMap[recipeName] = recipe;
    notifyListeners();
  }

  void deleteRecipe(String recipeName) {
    recipeMap.remove(recipeName);
    notifyListeners();
  }

  List<String> getRecipeNames() {
    notifyListeners();
    return recipeMap.keys.toList();
  }

  Recipe getRecipeFromName(String recipeName) {
    notifyListeners();
    return recipeMap[recipeName]!;
  }
}
