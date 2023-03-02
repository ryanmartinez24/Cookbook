import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('I can get the correct number of keys that the JSON contains', () {
    String jsonObject = File('lib/Recipes.json').readAsStringSync();
    var decodedJsonObject = jsonDecode(jsonObject);
    int numOfKeys = decodedJsonObject.length;

    expect(numOfKeys, 1);
  });
}
