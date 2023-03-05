import 'dart:convert';
import 'dart:io';
import 'package:fp_recipe_book/ingredient.dart';

class RecipeParser {
  String jsonObject = File('lib/Recipes.json').readAsStringSync();
  late final decodedJsonObject;
  final int recipeNumber;
  late final String recipe;

  RecipeParser(this.recipeNumber) {
    decodedJsonObject = jsonDecode(jsonObject);

    if (recipeNumber == 1) {
      recipe = "recipe1";
    } else if (recipeNumber == 2) {
      recipe = "recipe2";
    } else if (recipeNumber == 3) {
      recipe = "recipe3";
    } else {
      recipe = "recipe4";
    }
  }

  String descriptionRetriever() {
    String description =
        decodedJsonObject["$recipe"]["Description"].keys.elementAt(0);
    return description;
  }

  List<Ingredient> ingredientRetriever() {
    int numOfIngredients = decodedJsonObject[recipe]["Ingredients"].length;
    List<Ingredient> ingredients = [];
    for (int i = 0; i < numOfIngredients; i++) {
      String name = decodedJsonObject[recipe]["Ingredients"].keys.elementAt(i);
      int amount =
          int.parse((decodedJsonObject[recipe]["Ingredients"][name][0]));
      String measurementUnit =
          decodedJsonObject[recipe]["Ingredients"][name][1];

      Ingredient test = Ingredient(name, measurementUnit, amount);
      ingredients.add(test);
    }

    return ingredients;
  }

  String directionRetriever() {
    String directions = decodedJsonObject[recipe]["Directions"].value;
    return directions;
  }
}
