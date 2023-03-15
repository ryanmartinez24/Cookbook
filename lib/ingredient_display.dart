import 'package:fp_recipe_book/ingredient.dart';

class IngredientDisplay {
  List<Ingredient> ingredients;
  late String ingredientDisplay;

  IngredientDisplay(this.ingredients);

  String display() {
    ingredientDisplay = '';
    for (int i = 0; i < ingredients.length; i++) {
      ingredientDisplay =
          '$display \n${ingredients[i].amount} ${ingredients[i].measurementUnit} ${ingredients[i].name}';
    }

    return ingredientDisplay;
  }
}
