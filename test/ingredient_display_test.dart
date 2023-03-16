import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/ingredient_display.dart';
import 'package:fp_recipe_book/recipe_parser.dart';

void main() {
  RecipeParser parser = RecipeParser(1);
  List<Ingredient> ingredients = parser.ingredientRetriever();
  IngredientDisplay display = IngredientDisplay(ingredients);

  test('I can get the correct string of ingredients for the correct recipe',
      () {
    String ingredientDisplay = '';
    for (int i = 0; i < ingredients.length; i++) {
      ingredientDisplay =
          '$ingredientDisplay \n${ingredients[i].amount} ${ingredients[i].measurementUnit} ${ingredients[i].name}';
    }

    expect(display.display(), ingredientDisplay);
  });
}
