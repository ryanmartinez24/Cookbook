import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/units_of_volume.dart';

void main() {
  Ingredient pepper =
      Ingredient("Pepper", Measurement(3.0, UnitsOfVolume.whole));
  Ingredient beef =
      Ingredient("Ground Beef", Measurement(0.5, UnitsOfVolume.pounds));
  Ingredient oliveOil =
      Ingredient("Olive Oil", Measurement(3.0, UnitsOfVolume.tsp));

  final List<Ingredient> originalIngredients = [pepper, beef, oliveOil];

  Recipe testRecipe =
      Recipe("Chef's Special", "Da best", originalIngredients, "Cook it", 1);

  test('testing that recipe scale ingredient function works', () {
    testRecipe.scaleIngredients(5, 1);
    List<Ingredient> newIngredients = testRecipe.getIngredientsCopy();
    double scaledIngredientAmount = newIngredients[0].measurement.amount;
    UnitsOfVolume ingredientUnit = newIngredients[2].measurement.unitOfVolume;
    expect(scaledIngredientAmount, 15);
    expect(ingredientUnit, UnitsOfVolume.tbsp);
  });

  test("test that getIngredientsCopy returns deep copy as expected", () {
    List<Ingredient> copiedList = testRecipe.getIngredientsCopy();
    copiedList.remove(pepper);
    expect(copiedList.contains(pepper), false);
    expect(originalIngredients.contains(pepper), true);
  });
}
