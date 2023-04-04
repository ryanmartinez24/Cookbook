import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/add_ingredient_widget.dart';

class AddRecipeWidget extends StatefulWidget {
  AddRecipeWidget({super.key, required this.recipeMap, required this.update});
  Map recipeMap;
  final ValueChanged update;

  @override
  State<AddRecipeWidget> createState() => _AddRecipeWidgetState();
}

class _AddRecipeWidgetState extends State<AddRecipeWidget> {
  String recipeName = "";

  String directions = "";

  String description = "";

  List<Ingredient> ingredients = [];

  _update(List<Ingredient> newIngredients) {
    ingredients = newIngredients;
  }

  @override
  Widget build(BuildContext context) {
    AddIngredientWidget ingredientWidget = AddIngredientWidget(
      ingredients: ingredients,
      update: (ingredients) => _update(ingredients),
    );

    return Scaffold(
      body: Column(
        children: [
          const Text("Add a new Recipe!"),
          const Spacer(),
          const Text("Enter recipe name"),
          TextField(onChanged: (text) {
            recipeName = text;
          }),
          const Spacer(),
          const Text("Enter the description"),
          TextField(onChanged: (text) {
            description = text;
          }),
          const Spacer(),
          const Text("Enter the directions"),
          TextField(onChanged: (text) {
            directions = text;
          }),
          const Spacer(),
          const Text("Enter the ingredients"),
          ingredientWidget,
          ElevatedButton(
              onPressed: _submitRecipe, child: const Text("Submit Recipe")),
          const Spacer(),
          ElevatedButton(onPressed: _goHome, child: const Text("Homepage")),
        ],
      ),
    );
  }

  void _submitRecipe() {
    Recipe newRecipe =
        Recipe(recipeName, description, ingredients, directions, 1);
    widget.recipeMap[recipeName] = newRecipe;
  }

  void _goHome() {
    Navigator.pop(context);
    widget.update(widget.recipeMap);
  }
}
