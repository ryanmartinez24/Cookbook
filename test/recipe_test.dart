import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/recipe.dart';

void main() {
  Ingredient pepper = Ingredient("Pepper", Measurement("whole", 3.0));
  Ingredient beef = Ingredient("Ground Beef", Measurement("lbs", .5));
  Ingredient oliveOil = Ingredient("Olive Oil", Measurement("tsp", 3.0));

  final List<Ingredient> originalIngredients = [pepper, beef, oliveOil];

  Recipe testRecipe =
      Recipe("Chef's Special", "Da best", originalIngredients, "Cook it", 1);

  test('testing that recipe scale ingredient function works', () {
    testRecipe.scaleIngredients(5, 1);
    List<Ingredient> newIngredients = testRecipe.getIngredientsCopy();
    double i1ScaledAmount = newIngredients[0].measurement.amount;
    String i3Unit = newIngredients[2].measurement.unit;
    expect(i1ScaledAmount, 15);
    expect(i3Unit, "cups");
  });

  test("test that getIngredientsCopy returns deep copy as expected", () {
    List<Ingredient> copiedList = testRecipe.getIngredientsCopy();
    copiedList.remove(pepper);
    expect(copiedList.contains(pepper), false);
    expect(originalIngredients.contains(pepper), true);
  });
}
