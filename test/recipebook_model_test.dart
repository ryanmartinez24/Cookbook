import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipebook_model.dart';
import 'package:fp_recipe_book/storage.dart';

void main() {
  Ingredient i1 = Ingredient("Pepper", Measurement("whole", 3.0));
  Ingredient i2 = Ingredient("Ground Beef", Measurement("lbs", .5));
  Ingredient i3 = Ingredient("Olive Oil", Measurement("tsp", 3.0));

  List<Ingredient> ingredientList = [i1, i2, i3];

  Recipe testRecipe =
      Recipe("Chef's Special", "Da best", ingredientList, "Cook it", 1);

  List<String> recipeNames = [
    "Meat Sauce",
    "Mashed Potatoes",
    "Chicken Noodle Soup",
    "Chocolate Chip Cookies",
    "Chef's Special"
  ];

  RecipeBookModel model = RecipeBookModel();

  String testRecipeName = testRecipe.getRecipeName();

  test('I can add a recipe to the recipe model', () {
    model.addRecipe(testRecipeName, testRecipe);

    expect(model.getRecipeMap()[testRecipeName], testRecipe);
  });

  test('I can remove a recipe from the recipe model', () {
    model.deleteRecipe(testRecipeName);

    expect(model.getRecipeMap().containsValue(testRecipeName), false);
  });

  test('I can get a recipe from the model by name', () {
    model.addRecipe(testRecipeName, testRecipe);

    expect(model.getRecipeFromName(testRecipeName), testRecipe);
  });

  test("I can get the correct list of recipes from the model", () {
    expect(model.getRecipeNames(), recipeNames);
  });

  test("json encode/decode works with model", () async {
    Storage storage = Storage();
    String encodedModel = jsonEncode(model);
    storage.writeRecipes(encodedModel);
    String reEncodedModel = await storage.readRecipes();
    var decodedJson = jsonDecode(reEncodedModel);
    RecipeBookModel model2 = RecipeBookModel.fromJson(decodedJson);
    expect(model.getRecipeNames(), model2.getRecipeNames());
  });
}
