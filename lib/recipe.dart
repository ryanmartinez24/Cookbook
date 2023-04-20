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
}
