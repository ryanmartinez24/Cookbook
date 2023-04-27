import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/storage.dart';

void main() {
  Storage testStorage = Storage();

  // IMPORTANT, running this test will wipe out local storage and reset it
  test("test that storage can read and write to local storage", () async {
    Random randomGenerator = Random();
    int testNumber = randomGenerator.nextInt(1000);
    testStorage.writeRecipes("$testNumber");
    expect("$testNumber", await testStorage.readRecipes());

    //Reset local storage to empty if this test is  run so main app still works
    testStorage.writeRecipes("");
  });
}
