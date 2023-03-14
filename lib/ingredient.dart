class Ingredient {
  String name;
  String measurementUnit;
  double amount;

  Ingredient(this.name, this.measurementUnit, this.amount);

  void setAmount(newAmount) {
    amount = newAmount;
  }
}
