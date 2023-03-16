import 'ingredient.dart';

class ServingScaler {
  final List<Ingredient> ingredients;

  ServingScaler(this.ingredients);

  List<Ingredient> amountScaler(double servings) {
    for (int i = 0; i < ingredients.length; i++) {
      double amount = ingredients[i].amount;
      amount = amount * servings;
      ingredients[i].amount = amount;
    }
    return ingredients;
  }
}
