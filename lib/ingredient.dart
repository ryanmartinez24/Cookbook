import 'package:fp_recipe_book/measurement.dart';

class Ingredient {
  final String _name;
  final Measurement _measurement;

  Ingredient(this._name, this._measurement);

  // Returns Deepcopy of Ingredient
  Ingredient getCopy() {
    return Ingredient(_name, _measurement.getCopy());
  }

  String getIngredientName() {
    return _name;
  }

  Measurement getMeasurement() {
    return _measurement;
  }

  Map toJson() {
    Map measurement = _measurement.toJson();
    return {
      "measurementName": _name,
      "measurement": measurement,
    };
  }

  factory Ingredient.fromJson(dynamic json) {
    return Ingredient(
        json['measurementName'], Measurement.fromJson(json['measurement']));
  }
}
