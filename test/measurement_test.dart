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
    expect(oliveOil.getMeasurement().getUnit(), "tbsp");
    expect(oliveOil.getMeasurement().getAmount(), 1.0);
  });

  test('testing that scale function works', () {
    pepper.getMeasurement().scale(5);
    expect(pepper.getMeasurement().getAmount(), 15);
  });

  test('testing that scale function simplifies after', () {
    oliveOil.getMeasurement().scale(3);
    expect(oliveOil.getMeasurement().getUnit(), 'cups');
    expect(oliveOil.getMeasurement().getAmount(), 1.0);
  });

  test('I can convert the unit to gallons', () {
    butterInQuarts.getMeasurement().scale(6);
    expect(butterInQuarts.getMeasurement().getUnit(), 'gallons');
    expect(butterInQuarts.getMeasurement().getAmount(), 3.0);
  });

  test('I can convert the measurement to a smaller unit', () {
    butterInGallons.getMeasurement().scale(1 / 8);
    expect(butterInGallons.getMeasurement().getUnit(), 'quarts');
    expect(butterInGallons.getMeasurement().getAmount(), 2.0);
  });
}
