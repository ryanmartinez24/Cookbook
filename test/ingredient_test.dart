import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/units_of_volume.dart';

void main() {
  Ingredient originalPepper =
      Ingredient("Pepper", Measurement(3.0, UnitsOfVolume.whole));

  test("test that getCopy returns deep copy as expected", () {
    Ingredient pepperCopy = originalPepper.getCopy();
    originalPepper.measurement.scale(2.0);
    expect(pepperCopy.measurement.amount, 3.0);
  });

  String encodedJsonString = jsonEncode(originalPepper);
  var decodedJson = jsonDecode(encodedJsonString);
  Ingredient pepperFromJson = Ingredient.fromJson(decodedJson);

  test("I can encode/decode an ingredient to json", () {
    expect(decodedJson["measurementName"], "Pepper");
  });

  test("I can create an ingredient from an encoded ingredient", () {
    expect(originalPepper.ingredientName, pepperFromJson.ingredientName);
    expect(
        originalPepper.measurement.amount, pepperFromJson.measurement.amount);
    expect(originalPepper.measurement.unitOfVolume,
        pepperFromJson.measurement.unitOfVolume);
  });
}
