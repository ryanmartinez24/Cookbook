import 'package:flutter/material.dart';
import 'package:fp_recipe_book/new_recipe_model.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/add_ingredient_widget.dart';
import "package:provider/provider.dart";
import 'package:fp_recipe_book/recipes_model.dart';

class AddRecipeWidget extends StatefulWidget {
  const AddRecipeWidget({super.key});

  @override
  State<AddRecipeWidget> createState() => _AddRecipeWidgetState();
}

class _AddRecipeWidgetState extends State<AddRecipeWidget> {
  String recipeName = "";

  @override
  Widget build(BuildContext context) {
    AddIngredientWidget ingredientWidget = const AddIngredientWidget();

    return Scaffold(
      body: Column(
        children: [
          const Text("Add a new Recipe!"),
          const Spacer(),
          const Text("Enter recipe name"),
          TextField(onChanged: (text) {
            Provider.of<NewRecipeModel>(context, listen: false)
                .setRecipeName(text);
          }),
          const Spacer(),
          const Text("Enter the description"),
          TextField(onChanged: (text) {
            Provider.of<NewRecipeModel>(context, listen: false)
                .setDescription(text);
          }),
          const Spacer(),
          const Text("Enter the directions"),
          TextField(onChanged: (text) {
            Provider.of<NewRecipeModel>(context, listen: false)
                .setDirections(text);
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
    recipeName =
        Provider.of<NewRecipeModel>(context, listen: false).getRecipeName();
    Recipe newRecipe =
        Provider.of<NewRecipeModel>(context, listen: false).getNewRecipe();
    Provider.of<RecipesModel>(context, listen: false)
        .addRecipe(recipeName, newRecipe);
  }

  void _goHome() {
    Navigator.pop(context);
  }
}
