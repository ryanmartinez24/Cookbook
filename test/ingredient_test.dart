import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';

void main() {
  String jsonObject = File('lib/Recipes.json').readAsStringSync();
  var decodedJsonObject = jsonDecode(jsonObject);

  test('I can get the ingredients required to make a recipe', () {
    int numOfIngredients = decodedJsonObject["recipe1"]["Ingredients"].length;

    List<Ingredient> ingredients = [];

    for (int i = 0; i < numOfIngredients; i++) {
      String name =
          decodedJsonObject["recipe1"]["Ingredients"].keys.elementAt(i);
      int amount = int.parse(
          decodedJsonObject["recipe1"]["Ingredients"]["$name"]["Amount"]);
      String measurementUnit =
          decodedJsonObject["recipe1"]["Ingredients"]["$name"]["Unit"];

      Ingredient test = Ingredient(name, measurementUnit, amount);
      ingredients.add(test);
    }

    String theIngredients = '';

    for (int j = 0; j < ingredients.length; j++) {
      String ingredientName = ingredients[j].name;
      theIngredients = '$theIngredients$ingredientName, ';
    }

    expect(theIngredients, "Salt, Pepper, ");
  });
}