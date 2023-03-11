import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipeParser.dart';

void main() {
  RecipeParser parser = RecipeParser(1);
  String name = parser.nameRetriever();
  String description = parser.descriptionRetriever();
  List<Ingredient> ingredients = parser.ingredientRetriever();
  String directions = parser.directionRetriever();

  Recipe testRecipe = Recipe(name, description, ingredients, directions);

  test('I can retrieve the name of recipe1 based off of the Json information',
      () {
    String testName = testRecipe.recipeName;

    expect(testName, name);
  });

  test(
      'I can retrieve the description of recipe1 based on the Json informations',
      () {
    String testDescription = testRecipe.description;

    expect(testDescription, description);
  });

  test(
      'I can retrieve the entire list of Ingredient Objects for recipe1 based off of the Json information',
      () {
    List<Ingredient> testIngredients = testRecipe.ingredients;

    expect(testIngredients, ingredients);
  });

  test(
      'I can retrieve the directions for recipe1 based on the Json information',
      () {
    String testDirections = testRecipe.directions;

    expect(testDirections, directions);
  });
}
