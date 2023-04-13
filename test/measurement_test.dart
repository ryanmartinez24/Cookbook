import 'package:fp_recipe_book/measurement.dart';
import 'package:test/test.dart';
import 'package:fp_recipe_book/ingredient.dart';

void main() {
  Ingredient i1 = Ingredient("Pepper", Measurement("whole", 3.0));
  Ingredient i2 = Ingredient("Olive Oil", Measurement("tsp", 3.0));
  Ingredient i3 = Ingredient('Butter', Measurement('quarts', 2));
  Ingredient i4 = Ingredient('Butter', Measurement('gallons', 4.0));

  test('testing that measurement simplifies on creation', () {
    expect(i2.measurement.unit, "tbsp");
    expect(i2.measurement.amount, 1.0);
  });

  test('testing that scale function works', () {
    i1.measurement.scale(5);
    expect(i1.measurement.amount, 15);
  });

  test('testing that scale function simplifies after', () {
    i2.measurement.scale(3);
    expect(i2.measurement.unit, 'cups');
    expect(i2.measurement.amount, 1.0);
  });

  test('I can convert the unit to gallons', () {
    i3.measurement.scale(6);
    expect(i3.measurement.unit, 'gallons');
    expect(i3.measurement.amount, 3.0);
  });

  test('I can convert the measurement to a smaller unit', () {
    i4.measurement.scale(1 / 8);
    expect(i4.measurement.unit, 'quarts');
    expect(i4.measurement.amount, 2.0);
  });
}
