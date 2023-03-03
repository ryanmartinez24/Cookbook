//makes recipe objects from json information
//takes json
//stores the keys as variables
//decode method
//encode method
import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  final String directions;
  final String description;
  final List<Ingredient> ingredients;

  late final decodedJsonObject;

  Recipe(this.directions, this.description, this.ingredients);

  List<Ingredient> ingredientRetriever() {
    int numOfIngredients = decodedJsonObject["recipe1"]["Ingredients"].length;
    List<Ingredient> ingredients = [];
    for (int i = 0; i < numOfIngredients; i++) {
      String name =
          decodedJsonObject["recipe1"]["Ingredients"].keys.elementAt(i);
      int amount =
          int.parse((decodedJsonObject["recipe1"]["Ingredients"][name][0]));
      String measurementUnit =
          decodedJsonObject["recipe1"]["Ingredients"][name][1];

      Ingredient test = Ingredient(name, measurementUnit, amount);
      ingredients.add(test);
    }

    return ingredients;
  }
}
