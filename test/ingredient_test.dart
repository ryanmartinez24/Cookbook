import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';

void main() {
  String jsonObject = File('assets/recipes.json').readAsStringSync();
  var decodedJsonObject = jsonDecode(jsonObject);

  test(
      'I can get the ingredients required to make the first recipe in '
      'the json file', () {
    int numOfIngredients = decodedJsonObject["recipe1"]["Ingredients"].length;

    List<Ingredient> ingredients = [];

    for (int i = 0; i < numOfIngredients; i++) {
      String name =
          decodedJsonObject["recipe1"]["Ingredients"].keys.elementAt(i);
      double amount = double.parse(
          decodedJsonObject["recipe1"]["Ingredients"][name]["Amount"]);
      String measurementUnit =
          decodedJsonObject["recipe1"]["Ingredients"][name]["Unit"];

      Ingredient test = Ingredient(name, measurementUnit, amount);
      ingredients.add(test);
    }

    String theIngredients = '';

    for (int j = 0; j < ingredients.length; j++) {
      String ingredientName = ingredients[j].name;
      theIngredients = '$theIngredients$ingredientName, ';
    }

    expect(theIngredients,
        "Ground Beef, Medium onion, chopped, Cloves garlic, minced, Small green bell pepper, diced, Canned diced tomatoes, Tomato sauce, Tomato paste, Dried oregano, Dried basil, Salt, Pepper, ");
  });
}
