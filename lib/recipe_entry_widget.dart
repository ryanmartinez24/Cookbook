import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/ingredient_change_notifier.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/ingredient_entry_widget.dart';
import "package:provider/provider.dart";
import 'package:fp_recipe_book/recipebook_model.dart';

class RecipeEntryWidget extends StatefulWidget {
  const RecipeEntryWidget({
    super.key,
  });

  @override
  State<RecipeEntryWidget> createState() => _RecipeEntryWidgetState();
}

class _RecipeEntryWidgetState extends State<RecipeEntryWidget> {
  String _recipeName = "";
  String _directions = "";
  String _description = "";
  double _servings = 1;

  bool _hasChosenName = false;
  bool _hasChosenDirections = false;
  bool _hasChosenDescription = false;
  bool _hasChosenServings = false;
  bool _hasIngredients = false;

  List<Ingredient> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    IngredientEntryWidget ingredientWidget = IngredientEntryWidget(
      onIngredientCreated: onIngredientCreated,
    );

    return Scaffold(
      body: Column(
        children: [
          const Text("Add a new Recipe!"),
          const Spacer(),
          const Text("Enter recipe name"),
          TextField(
            onChanged: (text) => _onRecipeNameChanged(text),
          ),
          const Spacer(),
          const Text("Enter the description"),
          TextField(
            onChanged: (text) => _onDescriptionChanged(text),
          ),
          const Spacer(),
          const Text("Enter the directions"),
          TextField(
            onChanged: (text) => _onDirectionsChanged(text),
          ),
          const Spacer(),
          const Text("Enter the amount of servings the recipe makes"),
          TextField(
            onChanged: (text) => _onServingsChanged(text),
          ),
          const Spacer(),
          const Text("Enter the ingredients"),
          ingredientWidget,
          ElevatedButton(
              onPressed: _isValidRecipe() ? _submitRecipe : null,
              child: const Text("Submit Recipe")),
          const Spacer(),
          ElevatedButton(onPressed: _goHome, child: const Text("Homepage")),
        ],
      ),
    );
  }

  void onIngredientCreated() {
    setState(() {
      _hasIngredients = true;
    });
  }

  bool _isValidRecipe() {
    return _hasChosenName &&
        _hasChosenDescription &&
        _hasChosenDirections &&
        _hasChosenServings &&
        _hasIngredients;
  }

  void _onRecipeNameChanged(text) {
    setState(() {
      _recipeName = text;
      _hasChosenName = true;
    });
  }

  void _onDescriptionChanged(text) {
    setState(() {
      _description = text;
      _hasChosenDescription = true;
    });
  }

  void _onServingsChanged(text) {
    setState(() {
      _servings = double.parse(text);
      _hasChosenServings = true;
    });
  }

  void _onDirectionsChanged(text) {
    setState(() {
      _directions = text;
      _hasChosenDirections = true;
    });
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
