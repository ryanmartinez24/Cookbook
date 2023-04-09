import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipes_model.dart';

void main() {
  Map<String, Recipe> recipeMap = RecipesModel().recipeMap;

  test('I can add data to my local storage', () {
    Recipe newRecipe = Recipe(
        'Coconut Shrimp',
        'Good stuff',
        [
          Ingredient('Coconut', Measurement('cups', 0.5)),
          Ingredient('Shrimp', Measurement('', 12))
        ],
        'Cover shrimp in coconut and cook.',
        2);

    RecipesModel().addRecipe('Coconut Shrimp', newRecipe);
  });
}
