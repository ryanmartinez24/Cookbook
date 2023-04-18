import 'package:fp_recipe_book/measurement.dart';

class Ingredient {
  String name;
  Measurement measurement;

  Ingredient(this.name, this.measurement);

  // Returns Deepcopy of Ingredient
  Ingredient getCopy() {
    return Ingredient(name, measurement);
  }
}
