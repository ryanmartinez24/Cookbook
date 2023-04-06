import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/new_recipe_model.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fp_recipe_book/add_recipe_widget.dart';
import "package:fp_recipe_book/recipes_model.dart";
import "package:fp_recipe_book/delete_recipe_widget.dart";

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipesModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme:
            GoogleFonts.merriweatherTextTheme(Theme.of(context).textTheme),
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class RecipeWidget extends StatefulWidget {
  const RecipeWidget({
    super.key,
    required this.currentRecipe,
  });
  final Recipe currentRecipe;

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.currentRecipe.recipeName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("\n ${widget.currentRecipe.description}"),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Desired Servings:\n",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  )),
              Row(
                children: [
                  const SizedBox(
                    height: 0,
                    width: 120,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: TextField(
                        onSubmitted: _onServingChosen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20, width: 20),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Ingredients:",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "\n${_displayIngredients(widget.currentRecipe.ingredients)}"),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Directions:",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("\n ${widget.currentRecipe.directions}")),
              const SizedBox(height: 20, width: 20),
            ],
          )),
          ElevatedButton(onPressed: _goHome, child: const Text("Homepage"))
        ],
      )),
    );
  }

  void _onServingChosen(String? number) {
    if (number != null) {
      double servingNumber = double.parse(number);
      setState(() {
        double scaleFactor = servingNumber / widget.currentRecipe.scale;
        widget.currentRecipe.scaleIngredients(scaleFactor);
        widget.currentRecipe.scale = servingNumber;
      });
    }
  }

  void _goHome() {
    Navigator.pop(context);
  }

  String _displayIngredients(List<Ingredient> ingredients) {
    String ingredientDisplay = '';

    for (int i = 0; i < ingredients.length; i++) {
      double amount = ingredients[i].measurement.amount;
      String measurementUnit = ingredients[i].measurement.unit;
      String name = ingredients[i].name;
      ingredientDisplay = '$ingredientDisplay \n$amount $measurementUnit $name';
    }

    return ingredientDisplay;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List recipeList = Provider.of<RecipesModel>(context).getRecipeNames();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Cookbook!",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 50,
              ),
            ),
            DropdownButton(
                items: recipeList.map<DropdownMenuItem<String>>((recipeName) {
                  return DropdownMenuItem<String>(
                    value: recipeName,
                    child: Text(recipeName),
                  );
                }).toList(),
                onChanged: _onRecipeSelected),
            ElevatedButton(
                onPressed: _onCreateRecipeSelected,
                child: const Text("Create new recipe")),
            ElevatedButton(
                onPressed: _onDeleteRecipeSelected,
                child: const Text("Delete an existing recipe")),
          ],
        ),
      ),
    );
  }

  void _onRecipeSelected(String? recipe) {
    if (recipe != null) {
      Recipe currentRecipe = Provider.of<RecipesModel>(context, listen: false)
          .getRecipeFromName(recipe);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RecipeWidget(
                    currentRecipe: currentRecipe,
                  )));
    }
  }

  void _onCreateRecipeSelected() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChangeNotifierProvider(
                create: (context) => NewRecipeModel(),
                child: const AddRecipeWidget()),
      ),
    );
  }

  void _onDeleteRecipeSelected() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DeleteRecipeWidget()
        )
    );
  }
}