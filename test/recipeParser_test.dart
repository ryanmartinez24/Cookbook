import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipeParser.dart';

void main() {
  RecipeParser tester = RecipeParser(2);

  test('I can get the name of the recipe of my choice', () {
    String name = tester.nameRetriever();

    expect(name, 'Mashed Potatoes');
  });

  test('I can access the description of the recipe of my choice', () {
    String description = tester.descriptionRetriever();

    expect(description,
        "Simple and easy homemade mashed potatoes (recipe designed for 10 servings)");
  });

  test(
      'I can access the names in the list of ingredients of the recipe of my choice',
      () {
    List<Ingredient> ingredients = tester.ingredientRetriever();

    String theIngredients = '';

    for (int j = 0; j < ingredients.length; j++) {
      String ingredientName = ingredients[j].name;
      theIngredients = '$theIngredients$ingredientName, ';
    }

    expect(theIngredients,
        "Russet potatoes, peeled, cut into quarters, Salt, Butter (optional), Pepper, Hot milk, ");
  });

  test('I can get the directions of the recipe of my choice', () {
    String directions = tester.directionRetriever();

    expect(
        directions,
        "1: Place potatoes in large saucepan; add enough water to cover. Add ¾ of the salt. Bring to a boil. Reduce heat to medium-low; cover loosely and boil gently for 15 to 20 minutes or until potatoes break apart easily when pierced with fork. Drain well. \n"
        '2: Return potatoes to saucepan; shake saucepan gently over low heat for 1 to 2 minutes to evaporate any excess moisture. \n'
        ' 3: Mash potatoes with potato masher until no lumps remain. Add butter, pepper and remaining salt; continue mashing, gradually adding enough milk to make potatoes smooth and creamy');
  });

  test('I can find the runtime of decodedJsonObject in the recipeParser class',
      () {
    final decodedJsonObject = tester.decodedJsonObject;
    String runtimeType = '${decodedJsonObject.runtimeType}';
    expect(runtimeType, '_InternalLinkedHashMap<String, dynamic>');
  });
}
