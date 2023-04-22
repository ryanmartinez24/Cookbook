import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  final String _recipeName;
  final String _description;
  final List<Ingredient> _ingredients;
  final String _directions;
  double _scale;

  Recipe(this._recipeName, this._description, this._ingredients,
      this._directions, this._scale);

  void scaleIngredients(double servings) {
    for (Ingredient ingredient in _ingredients) {
      ingredient.getMeasurement().scale(servings);
    }
    _scale = servings;
  }

  List<Ingredient> getIngredientsCopy() {
    final List<Ingredient> ingredientsCopy = [];
    for (Ingredient ingredient in _ingredients) {
      ingredientsCopy.add(ingredient.getCopy());
    }
    return ingredientsCopy;
  }

  String getRecipeName() {
    return _recipeName;
  }

  String getDescription() {
    return _description;
  }

  String getDirections() {
    return _directions;
  }

  void scale(double newScale) {
    _scale = newScale;
  }

  double getScale() {
    return _scale;
  }

  toJson() {
    List<Map> ingredients = _ingredients.map((i) => i.toJson()).toList();
    return {
      "recipeName": _recipeName,
      "description": _description,
      "ingredients": ingredients,
      "directions": _directions,
      "scale": _scale,
    };
  }

  factory Recipe.fromJson(dynamic json) {
    var ingredientsJson = json['ingredients'] as List;

    List<Ingredient> _ingredients = [];
    for (dynamic ingredientString in ingredientsJson) {
      _ingredients.add(Ingredient.fromJson(ingredientString));
    }
    return Recipe(json["recipeName"] as String, json["description"] as String,
        _ingredients, json["directions"] as String, json["scale"] as double);
  }
}
