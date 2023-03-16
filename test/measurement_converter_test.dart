import 'package:flutter_test/flutter_test.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement_converter.dart';
import 'package:fp_recipe_book/recipe_parser.dart';
import 'package:fp_recipe_book/serving_scaler.dart';

void main() {
  RecipeParser parser = RecipeParser(1);
  MeasurementConverter converter = MeasurementConverter();

  double servings = 8;
  List<Ingredient> ingredientsTester = parser.ingredientRetriever();
  ServingScaler scaler = ServingScaler(ingredientsTester);
  ingredientsTester = scaler.amountScaler(servings);
  List<Ingredient> ingredients =
      converter.convertIngredients(ingredientsTester);

  test(
      'I can change the number of servings and the units will convert if necessary',
      () {
    for (int i = 0; i < ingredients.length; i++) {
      Ingredient ingredient = ingredients[i];
      double ingredientAmount = ingredient.amount;
      String ingredientUnit = ingredient.measurementUnit;

      ingredientAmount = amountConverter(ingredientAmount, ingredientUnit);
      ingredientUnit = unitConverter(ingredientAmount, ingredientUnit);

      ingredient.amount = ingredientAmount;
      ingredient.measurementUnit = ingredientUnit;
    }

    expect(ingredientsTester, ingredients);
  });
}

amountConverter(double n, String unit) {
  double amount = n;

  if (unit == "pinch") {
    if (n > 1 && n < 16) {
      amount = n / 16;
    }
  } else if (unit == "tsp") {
    if (n >= 3 && n < 6) {
      amount = (n / 3);
    }
    if (n >= 6 && n < 48) {
      amount = (n / 6);
    }
    if (n >= 48 && n < 96) {
      amount = (n / 48);
    }
    if (n >= 96 && n < 192) {
      amount = (n / 96);
    }
    if (n >= 192 && n < 768) {
      amount = (n / 192);
    }
    if (n >= 768) {
      amount = (n / 768);
    }
    return amount;
  }
  if (unit == "tbsp") {
    if (n >= 2 && n < 16) {
      amount = (n / 6);
    }
    if (n >= 16 && n < 32) {
      amount = (n / 16);
    }
    if (n >= 32 && n < 64) {
      amount = (n / 32);
    }
    if (n >= 64 && n < 256) {
      amount = (n / 64);
    }
    if (n >= 256) {
      amount = (n / 256);
    }
    return amount;
  }
  if (unit == "oz") {
    if (n >= 8 && n < 16) {
      amount = (n / 8);
    }
    if (n >= 16 && n < 32) {
      amount = (n / 16);
    }
    if (n >= 32 && n < 128) {
      amount = (n / 32);
    }
    if (n >= 128) {
      amount = (n / 128);
    }
    return amount;
  }
  if (unit == "cup") {
    if (n >= 2 && n < 4) {
      amount = (n / 2);
    }
    if (n >= 4 && n < 8) {
      amount = (n / 4);
    }
    if (n >= 16) {
      amount = (n / 16);
    }
    return amount;
  }
  if (unit == "pint") {
    if (n >= 2 && n < 8) {
      amount = (n / 2);
    }
    if (n >= 8) {
      amount = (n / 8);
    }
    return amount;
  }
  if (unit == "quart") {
    amount = (n / 4);

    return amount;
  }

  return amount;
}

unitConverter(double n, String unit) {
  String newUnit = unit;

  if (unit == "pinch") {
    if (n > 1 && n < 16) {
      newUnit = "tsp";
    }
  } else if (newUnit == "tsp") {
    if (n >= 3 && n < 6) {
      newUnit = "tbsp";
    }
    if (n >= 6 && n < 48) {
      newUnit = "oz";
    }
    if (n >= 48 && n < 96) {
      newUnit = "cup";
    }
    if (n >= 96 && n < 192) {
      newUnit = "pint";
    }
    if (n >= 192 && n < 768) {
      newUnit = "quart";
    }
    if (n >= 768) {
      newUnit = "gallon";
    }
    return newUnit;
  }
  if (unit == "tbsp") {
    if (n >= 2 && n < 16) {
      newUnit = "oz";
    }
    if (n >= 16 && n < 32) {
      newUnit = "cup";
    }
    if (n >= 32 && n < 64) {
      newUnit = "pint";
    }
    if (n >= 64 && n < 256) {
      newUnit = "quart";
    }
    if (n >= 256) {
      newUnit = "gallon";
    }
    return newUnit;
  }
  if (unit == "oz") {
    if (n >= 8 && n < 16) {
      newUnit = "cup";
    }
    if (n >= 16 && n < 32) {
      newUnit = "pint";
    }
    if (n >= 32 && n < 128) {
      newUnit = "quart";
    }
    if (n >= 128) {
      newUnit = "gallon";
    }

    return newUnit;
  }
  if (unit == "cup") {
    if (n >= 2 && n < 4) {
      newUnit = "pint";
    }
    if (n >= 4 && n < 8) {
      newUnit = "quart";
    }
    if (n >= 16) {
      newUnit = "gallon";
    }
    return newUnit;
  }
  if (unit == "pint") {
    if (n >= 2 && n < 8) {
      newUnit = "quart";
    }
    if (n >= 8) {
      newUnit = "gallon";
    }
    return newUnit;
  }
  if (unit == "quart") {
    newUnit = "gallon";

    return newUnit;
  }
  return newUnit;
}
