import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipe_parser.dart';
import 'package:fp_recipe_book/serving_scaler.dart';

void main() {
  test(
      'I can scale the amount of each ingredient so that I can make the number of servings that I want',
      () {
    RecipeParser parser = RecipeParser(1);
    List<Ingredient> ingredients = parser.ingredientRetriever();
    ServingScaler scaler = ServingScaler(ingredients);
    double servings = 10;
    List<Ingredient> newIngredients = scaler.amountScaler(servings);

    for (int i = 0; i < ingredients.length; i++) {
      double amount = ingredients[i].amount;
      amount = amount * servings;
      ingredients[i].setAmount(amount);
    }

    expect(newIngredients, ingredients);
  });
}
