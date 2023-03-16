import 'package:fp_recipe_book/ingredient.dart';

class IngredientDisplay {
  List<Ingredient> ingredients;
  late String ingredientDisplay;

  IngredientDisplay(this.ingredients);

  String display() {
    ingredientDisplay = '';
    for (int i = 0; i < ingredients.length; i++) {
      double amount = ingredients[i].amount;
      String measurementUnit = ingredients[i].measurementUnit;
      String name = ingredients[i].name;
      ingredientDisplay = '$ingredientDisplay \n$amount $measurementUnit $name';
    }

    return ingredientDisplay;
  }
}
