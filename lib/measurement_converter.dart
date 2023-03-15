import 'package:fp_recipe_book/ingredient.dart';

class MeasurementConverter {
  late double amount;
  late String unit;

  List<Ingredient> convertIngredients(List<Ingredient> ingredients) {
    for (int i = 0; i < ingredients.length; i++) {
      Ingredient ingredient = ingredients[i];
      double ingredientAmount = ingredient.amount;
      String ingredientUnit = ingredient.measurementUnit;

      unitConverter(ingredientAmount, ingredientUnit);

      ingredient.setAmount(ingredientAmount);
      ingredient.setMeasurementUnit(ingredientUnit);
    }

    return ingredients;
  }

  unitConverter(double n, String unit) {
    if (unit == "teaspoon") {
      if (n >= 3 && n < 6) {
        unit = "tablespoon";
        n = (n / 3);
      }
      if (n >= 6 && n < 48) {
        unit = "oz";
        n = (n / 6);
      }
      if (n >= 48 && n < 96) {
        unit = "cup";
        n = (n / 48);
      }
      if (n >= 96 && n < 192) {
        unit = "pint";
        n = (n / 96);
      }
      if (n >= 192 && n < 768) {
        unit = "quart";
        n = (n / 192);
      }
      if (n >= 768) {
        unit = "gallon";
        n = (n / 768);
      }
      amount = n;
    }
    if (unit == "tablespoon") {
      if (n >= 2 && n < 16) {
        unit = "oz";
        n = (n / 6);
      }
      if (n >= 16 && n < 32) {
        unit = "cup";
        n = (n / 16);
      }
      if (n >= 32 && n < 64) {
        unit = "pint";
        n = (n / 32);
      }
      if (n >= 64 && n < 256) {
        unit = "quart";
        n = (n / 64);
      }
      if (n >= 256) {
        unit = "gallon";
        n = (n / 256);
      }
      amount = n;
    }
    if (unit == "oz") {
      if (n >= 8 && n < 16) {
        unit = "cup";
        n = (n / 8);
      }
      if (n >= 16 && n < 32) {
        unit = "pint";
        n = (n / 16);
      }
      if (n >= 32 && n < 128) {
        unit = "quart";
        n = (n / 32);
      }
      if (n >= 128) {
        unit = "gallon";
        n = (n / 128);
      }
      amount = n;
    }
    if (unit == "cup") {
      if (n >= 2 && n < 4) {
        unit = "pint";
        n = (n / 2);
      }
      if (n >= 4 && n < 8) {
        unit = "quart";
        n = (n / 4);
      }
      if (n >= 16) {
        unit = "gallon";
        n = (n / 16);
      }
      amount = n;
    }
    if (unit == "pint") {
      if (n >= 2 && n < 8) {
        unit = "quart";
        n = (n / 2);
      }
      if (n >= 8) {
        unit = "gallon";
        n = (n / 8);
      }
      amount = n;
    }
    if (unit == "quart") {
      unit = "gallon";
      n = (n / 4);
    }

    amount = n;
    unit = unit;
  }
}
