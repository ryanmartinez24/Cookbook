import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/add_ingredient_widget.dart';
import "package:provider/provider.dart";
import 'package:fp_recipe_book/recipes_model.dart';
import 'package:localstorage/localstorage.dart';

class AddRecipeWidget extends StatefulWidget {
  const AddRecipeWidget({super.key});

  @override
  State<AddRecipeWidget> createState() => _AddRecipeWidgetState();
}

class _AddRecipeWidgetState extends State<AddRecipeWidget> {
  late final LocalStorage storage;

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
    _storeRecipe(newRecipe);
    Provider.of<RecipesModel>(context, listen: false)
        .addRecipe(recipeName, newRecipe);
  }

  void _goHome() {
    Navigator.pop(context);
  }

  void _storeRecipe(Recipe recipe) {
    String recipeJson = jsonEncode(recipe);

    setState(() {
      storage = LocalStorage(recipeJson);
    });
  }
}
