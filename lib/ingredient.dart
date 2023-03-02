class Ingredient {
  String name;
  String measurementUnit;
  int amount;

  Ingredient(this.name, this.measurementUnit, this.amount);

  void amountScalar(int scale) {
    amount = amount * scale;
  }
}
