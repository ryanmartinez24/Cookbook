import 'package:fp_recipe_book/measurement.dart';
import 'package:test/test.dart';
import 'package:fp_recipe_book/ingredient.dart';

void main() {
  Ingredient i1 = Ingredient("Pepper", Measurement("whole", 3.0));
  Ingredient i3 = Ingredient("Olive Oil", Measurement("tsp", 3.0));

  test('testing that measurement simplifies on creation', () {
    expect(i3.measurement.unit, "tbsp");
    expect(i3.measurement.amount, 1.0);
  });

  test('testing that scale function works', () {
    i1.measurement.scale(5);
    expect(i1.measurement.amount, 15);
  });

  test('testing that scale function simplifies after', () {
    i3.measurement.scale(3);
    expect(i3.measurement.unit, 'tbsp');
    expect(i3.measurement.amount, 3.0);
  });
}
