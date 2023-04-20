import 'package:flutter_test/flutter_test.dart';

import 'package:fp_recipe_book/storage.dart';

void main() {
  Storage testStorage = Storage();

  // IMPORTANT, test message must be changed each time test is run for it to be
  // valid test
  test("test that storage can read and write to local storage", () async {
    testStorage.writeRecipes("testing read writes");
    expect("testing read writes", await testStorage.readRecipes());
  });
}
