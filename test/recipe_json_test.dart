import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String jsonObject = File('lib/Recipes.json').readAsStringSync();
  var decodedJsonObject = jsonDecode(jsonObject);

  test('I can get the correct number of keys that the JSON contains', () {
    int numOfKeys = decodedJsonObject.length;

    expect(numOfKeys, 4);
  });

  test(
      'I can get the correct number of ingredients required to make a specific recipe',
      () {
    int numOfIngredients = decodedJsonObject["recipe1"]["Ingredients"].length;

    expect(numOfIngredients, 11);
  });
}
