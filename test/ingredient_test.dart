import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';

void main() {
  Ingredient originalPepper = Ingredient("Pepper", Measurement("whole", 3.0));

  test("test that getCopy returns deep copy as expected", () {
    Ingredient pepperCopy = originalPepper.getCopy();
    originalPepper.measurement.scale(2.0);
    expect(pepperCopy.measurement.amount, 3.0);
  });
}
