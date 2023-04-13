import 'package:fp_recipe_book/measurement.dart';
import 'package:test/test.dart';
import 'package:fp_recipe_book/ingredient.dart';

void main() {
  Ingredient pepper = Ingredient("Pepper", Measurement("whole", 3.0));
  Ingredient oliveOil = Ingredient("Olive Oil", Measurement("tsp", 3.0));
  Ingredient butterInQuarts = Ingredient('Butter', Measurement('quarts', 2));
  Ingredient butterInGallons =
      Ingredient('Butter', Measurement('gallons', 4.0));

  test('testing that measurement simplifies on creation', () {
    expect(oliveOil.measurement.unit, "tbsp");
    expect(oliveOil.measurement.amount, 1.0);
  });

  test('testing that scale function works', () {
    pepper.measurement.scale(5);
    expect(pepper.measurement.amount, 15);
  });

  test('testing that scale function simplifies after', () {
    oliveOil.measurement.scale(3);
    expect(oliveOil.measurement.unit, 'cups');
    expect(oliveOil.measurement.amount, 1.0);
  });

  test('I can convert the unit to gallons', () {
    butterInQuarts.measurement.scale(6);
    expect(butterInQuarts.measurement.unit, 'gallons');
    expect(butterInQuarts.measurement.amount, 3.0);
  });

  test('I can convert the measurement to a smaller unit', () {
    butterInGallons.measurement.scale(1 / 8);
    expect(butterInGallons.measurement.unit, 'quarts');
    expect(butterInGallons.measurement.amount, 2.0);
  });
}
