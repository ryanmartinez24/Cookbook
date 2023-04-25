import 'package:fp_recipe_book/ingredient.dart';

class Recipe {
  final String _recipeName;
  final String _description;
  final List<Ingredient> _ingredients;
  final String _directions;
  double _scale;

  Recipe(this._recipeName, this._description, this._ingredients,
      this._directions, this._scale);

  void scaleIngredients(double newServing, double oldServing) {
    double servings = newServing / oldServing;
    for (Ingredient ingredient in _ingredients) {
      ingredient.measurement.scale(servings);
    }
    _scale = newServing;
  }

  List<Ingredient> getIngredientsCopy() {
    final List<Ingredient> ingredientsCopy = [];
    for (Ingredient ingredient in _ingredients) {
      ingredientsCopy.add(ingredient.getCopy());
    }
    return ingredientsCopy;
  }

  get recipeName {
    return _recipeName;
  }

  get description {
    return _description;
  }

  get directions {
    return _directions;
  }

  set setScale(double newScale) {
    _scale = newScale;
  }

  get scale {
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

    List<Ingredient> ingredients = [];
    for (dynamic ingredientString in ingredientsJson) {
      ingredients.add(Ingredient.fromJson(ingredientString));
    }
    return Recipe(json["recipeName"] as String, json["description"] as String,
        ingredients, json["directions"] as String, json["scale"] as double);
  }
}
