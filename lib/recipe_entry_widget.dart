import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/ingredient_change_notifier.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/ingredient_entry_widget.dart';
import "package:provider/provider.dart";
import 'package:fp_recipe_book/recipebook_model.dart';

class RecipeEntryWidget extends StatefulWidget {
  const RecipeEntryWidget({super.key});

  @override
  State<RecipeEntryWidget> createState() => _RecipeEntryWidgetState();
}

class _RecipeEntryWidgetState extends State<RecipeEntryWidget> {
  String _recipeName = "";
  String _directions = "";
  String _description = "";
  double _servings = -1;

  List<Ingredient> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    IngredientEntryWidget ingredientWidget = const IngredientEntryWidget();

    return Scaffold(
      body: Column(
        children: [
          const Text("Add a new Recipe!"),
          const Spacer(),
          const Text("Enter recipe name"),
          TextField(
            onChanged: (text) {
              _recipeName = text;
            },
          ),
          const Spacer(),
          const Text("Enter the description"),
          TextField(
            onChanged: (text) {
              _description = text;
            },
          ),
          const Spacer(),
          const Text("Enter the directions"),
          TextField(
            onChanged: (text) {
              _directions = text;
            },
          ),
          const Spacer(),
          const Text("Enter the amount of servings the recipe makes"),
          TextField(
            onChanged: (text) {
              _servings = double.parse(text);
            },
          ),
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
    _ingredients = Provider.of<IngredientChangeNotifier>(context, listen: false)
        .getIngredients();
    Recipe newRecipe =
        Recipe(_recipeName, _description, _ingredients, _directions, _servings);
    Provider.of<RecipeBookModel>(context, listen: false)
        .addRecipe(_recipeName, newRecipe);
  }

  void _goHome() {
    Navigator.pop(context);
  }
}
