import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipes_model.dart';

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

  RecipesModel model = RecipesModel();

  String testRecipeName = testRecipe.recipeName;

  test('I can add a recipe to the recipe model', () {
    model.addRecipe(testRecipeName, testRecipe);

    expect(model.recipeMap[testRecipeName], testRecipe);
  });

  test('I can remove a recipe from the recipe model', () {
    model.deleteRecipe(testRecipeName);

    expect(model.recipeMap.containsValue(testRecipeName), false);
  });

  test('I can get a recipe from the model by name', () {
    model.addRecipe(testRecipeName, testRecipe);

    expect(model.getRecipeFromName(testRecipeName), testRecipe);
  });

  test("I can get the correct list of recipes from the model", () {
    expect(model.getRecipeNames(), recipeNames);
  });
}
