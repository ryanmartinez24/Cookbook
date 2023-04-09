import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/recipe.dart';

void main() {
  Ingredient i1 = Ingredient("Pepper", Measurement("whole", 3.0));
  Ingredient i2 = Ingredient("Ground Beef", Measurement("lbs", .5));
  Ingredient i3 = Ingredient("Olive Oil", Measurement("tsp", 3.0));

  List<Ingredient> ingredientList = [i1, i2, i3];

  Recipe testRecipe =
      Recipe("Chef's Special", "Da best", ingredientList, "Cook it", 1);

  test('testing that recipe scale ingredient function works', () {
    testRecipe.scaleIngredients(5);
    List<Ingredient> newIngredients = testRecipe.ingredients;
    double i1ScaledAmount = newIngredients[0].measurement.amount;
    String i3Unit = newIngredients[2].measurement.unit;
    expect(i1ScaledAmount, 15);
    expect(i3Unit, "cups");
  });
}
