import 'ingredient.dart';

class ServingScaler {
  final List<Ingredient> ingredients;

  ServingScaler(this.ingredients);

  List<Ingredient> amountScaler(int servings) {
    for (int i = 0; i < ingredients.length; i++) {
      int amount = ingredients[i].amount;
      amount = amount * servings;
      ingredients[i].setAmount(amount);
    }
    return ingredients;
  }
}
