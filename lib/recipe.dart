//makes recipe objects from json information
//takes json
//stores the keys as variables
//decode method
//encode method
import 'dart:convert';
import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  late final jsonData;
  late final decodedJsonObject;

  Recipe(this.jsonData) {
    jsonDecoder();
  }

  String jsonDecoder() {
    decodedJsonObject = jsonData.decode();
    return decodedJsonObject;
  }

  List<Ingredient> ingredientRetriever() {
    int numOfIngredients =
        decodedJsonObject["Recipes"]["recipe1"]["Ingredients"].length;
    List<Ingredient> ingredients = [];
    for (int i = 0; i < numOfIngredients; i++) {
      String name = decodedJsonObject["Recipes"]["recipe1"]["Ingredients"]
          .keys
          .elementAt(i);
      int amount = int.parse(
          (decodedJsonObject["Recipes"]["recipe1"]["Ingredients"][name][0]));
      String measurementUnit =
          decodedJsonObject["Recipes"]["recipe1"]["Ingredients"]["$name"][1];

      Ingredient test = Ingredient(name, measurementUnit, amount);
      ingredients.add(test);
    }

    return ingredients;
  }
}
