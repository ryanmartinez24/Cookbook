import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipeParser.dart';

void main() {
  RecipeParser tester = RecipeParser(2);

  test('I can get the name of the recipe of my choice', () {
    String name = tester.nameRetriever();

    expect(name, 'yahoo');
  });

  test('I can access the description of the recipe of my choice', () {
    String description = tester.descriptionRetriever();

    expect(description, "This recipe is absolutely to die for");
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

    expect(theIngredients, "Salt, Pepper, ");
  });

  test('I can get the directions of the recipe of my choice', () {
    String directions = tester.directionRetriever();

    expect(directions,
        "1: pour salt on the floor \n 2: lick the salt on the floor");
  });

  test('I can find the runtime of decodedJsonObject in the recipeParser class',
      () {
    final decodedJsonObject = tester.decodedJsonObject;
    String runtimeType = '${decodedJsonObject.runtimeType}';
    expect(runtimeType, '_InternalLinkedHashMap<String, dynamic>');
  });
}
