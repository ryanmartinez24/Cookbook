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

  Map<String, Recipe> recipeMap = RecipesModel().recipeMap;

  RecipesModel model = RecipesModel();

  test('I can add a recipe to the recipe model', () {
    model.addRecipe(testRecipe.recipeName, testRecipe);

    recipeMap[testRecipe.recipeName] = testRecipe;

    for (int i = 0; i < recipeMap.length; i++) {
      expect(recipeMap[i], model.recipeMap[i]);
    }
  });

  test('I can remove a recipe from the recipe model', () {});
}
