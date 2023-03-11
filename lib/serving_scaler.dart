import 'ingredient.dart';

class ServingScaler {
  final List<Ingredient> ingredients;

  ServingScaler(this.ingredients);

  List<Ingredient> amountScaler(int scale) {
    for (int i = 0; i < ingredients.length; i++) {
      int amount = ingredients[i].amount;
      amount = amount * scale;
      ingredients[i].setAmount(amount);
    }
    return ingredients;
  }
}
