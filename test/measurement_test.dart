import 'dart:convert';

import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/units_of_volume.dart';
import 'package:test/test.dart';

void main() {
  test('I can convert the amount in pinches to the amount in tsp', () {
    double amountInPinches = 16;
    Measurement measurement =
        Measurement(amountInPinches, UnitsOfVolume.pinches);
    double amountInTsp = measurement.convert(UnitsOfVolume.tsp);

    expect(amountInTsp, 1);
  });

  test('I can convert the amount in tsp to the amount in tbsp', () {
    double amountInTsp = 6;
    Measurement measurementTest = Measurement(amountInTsp, UnitsOfVolume.tsp);
    double amountInTbsp = measurementTest.convert(UnitsOfVolume.tbsp);

    expect(amountInTbsp, 2);
  });

  test('I can convert the amount in gallons to the amount in cups', () {
    double amountInGallons = 0.125;
    Measurement measurement =
        Measurement(amountInGallons, UnitsOfVolume.gallon);
    double amountInCups = measurement.convert(UnitsOfVolume.cup);

    expect(amountInCups, 2);
  });

  test('I can automate simplifying the unit based on the amount', () {
    double amountInTsp = 6;
    var unitOfVolume = UnitsOfVolume.tsp;
    Measurement measurementTest = Measurement(amountInTsp, unitOfVolume);
    double newAmount = amountInTsp;

    for (int i = 0; i < 7; i++) {
      var unit = UnitsOfVolume.values[i];
      if (unit.inPinches < amountInTsp * unitOfVolume.inPinches) {
        newAmount = measurementTest.convert(unit);
      }
    }

    expect(newAmount, 2);
    expect(measurementTest.unitOfVolume, UnitsOfVolume.tbsp);
  });

  UnitsOfVolume unit = UnitsOfVolume.tsp;
  Measurement measurement = Measurement(2, unit);
  String json = jsonEncode(unit.name);

  test('I can serialize the unitOfVolume for persistence', () {
    expect(json, '"tsp"');
  });

  test('I can deserialize the unitOfVolume from persistence', () {
    String unitAsString = jsonDecode(json);
    UnitsOfVolume deserializedUnit = UnitsOfVolume.values.byName(unitAsString);

    expect(deserializedUnit, unit);
  });

  test('I can create a Measurement from a serialized version of it', () {
    Map measurementJson = measurement.toJson();
    Measurement measurementFromJson = Measurement.fromJson(measurementJson);
    double amountFromJson = measurementFromJson.amount;
    UnitsOfVolume unitFromJson = measurementFromJson.unitOfVolume;

    expect(amountFromJson, 2);
    expect(unitFromJson, unit);
  });

  test('I can find the name of the unitOfVolume', () {
    expect(unit.name, 'tsp');
  });
}
