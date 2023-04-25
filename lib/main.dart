import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/ingredient_change_notifier.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fp_recipe_book/add_recipe_widget.dart';
import "package:fp_recipe_book/recipebook_model.dart";
import "package:fp_recipe_book/delete_recipe_widget.dart";
import "package:fraction/fraction.dart";
import "dart:math" as math;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeBookModel(),
      child: MyApp(storage: Storage()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.storage});
  final Storage storage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme:
            GoogleFonts.merriweatherTextTheme(Theme.of(context).textTheme),
      ),
      home: FutureBuilder<String>(
          future: storage.readRecipes(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> children = [];
            if (snapshot.hasData && snapshot.data != "") {
              RecipeBookModel updatedModel =
                  RecipeBookModel.fromJson(jsonDecode(snapshot.data!));
              Map<String, Recipe> updatedMap = updatedModel.getMap();
              Provider.of<RecipeBookModel>(context, listen: false)
                  .updateMap(updatedMap);
              return MyHomePage(storage: storage, title: 'Recipe Book');
            } else if (snapshot.hasData) {
              return MyHomePage(title: "Recipe", storage: storage);
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ));
          }),
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
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Currently Serves ${widget.currentRecipe.scale} \n\n Desired Servings:\n",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
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
                    "\n${_displayIngredients(widget.currentRecipe.getIngredientsCopy())}"),
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
          ElevatedButton(onPressed: _goHome, child: const Text("Homepage")),
        ],
      )),
    );
  }

  void _onServingChosen(String? number) {
    if (number != null) {
      double servingNumber = double.parse(number);
      setState(() {
        double oldServingNumber = widget.currentRecipe.scale;
        widget.currentRecipe.scaleIngredients(servingNumber, oldServingNumber);
      });
    }
  }

  //Stringifies ingredients to be displayed.
  // takes into account whether it is a whole number or fraction.
  String _displayIngredients(List<Ingredient> ingredients) {
    String ingredientDisplay = '';

    for (int i = 0; i < ingredients.length; i++) {
      double doubleAmount = _roundDouble(ingredients[i].measurement.amount, 2);
      String measurementUnit = ingredients[i].measurement.unit;
      String name = ingredients[i].ingredientName;
      MixedFraction fractionAmount = MixedFraction.fromDouble(doubleAmount);
      if (fractionAmount.isWhole || fractionAmount.numerator == 0) {
        ingredientDisplay =
            '$ingredientDisplay \n$doubleAmount $measurementUnit $name';
      } else {
        ingredientDisplay =
            '$ingredientDisplay \n$fractionAmount $measurementUnit $name';
      }
    }

    return ingredientDisplay;
  }

  double _roundDouble(double val, int n) {
    num modNDegree = math.pow(10.0, n);
    return ((val * modNDegree).round().toDouble() / modNDegree);
  }

  void _goHome() {
    Navigator.pop(context);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.storage,
  });

  final String title;
  final Storage storage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasSelectedRecipe = false;
  String? chosenRecipeName = '';

  @override
  Widget build(BuildContext context) {
    List recipeList = Provider.of<RecipeBookModel>(context).getRecipeNames();

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
              onChanged: (String? recipeName) {
                setState(() {
                  _hasSelectedRecipe = true;
                  chosenRecipeName = recipeName;
                });
                _onRecipeSelected(recipeName);
              },
            ),
            ElevatedButton(
              onPressed: _hasSelectedRecipe
                  ? () {
                      _onGoToRecipeButtonPressed(chosenRecipeName);
                    }
                  : null,
              child: const Text('Go To Selected Recipe'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _onCreateRecipeSelected,
              child: const Text("Create new recipe"),
            ),
            ElevatedButton(
              onPressed: _onDeleteRecipeSelected,
              child: const Text("Delete an existing recipe"),
            ),
          ],
        ),
      ),
    );
  }

  void _onRecipeSelected(String? recipeName) {
    if (recipeName != null) {
      setState(() {
        _hasSelectedRecipe = true;
        chosenRecipeName = recipeName;
      });
    }
  }

  void _onGoToRecipeButtonPressed(String? recipeName) {
    if (recipeName != '') {
      Recipe currentRecipe =
          Provider.of<RecipeBookModel>(context, listen: false)
              .getRecipeFromName(recipeName!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeWidget(
            currentRecipe: currentRecipe,
          ),
        ),
      );
      setState(() {
        _hasSelectedRecipe = false;
      });
    }
  }

  void _onCreateRecipeSelected() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (context) => IngredientChangeNotifier(),
            child: const AddRecipeWidget()),
      ),
    );
  }

  void _onDeleteRecipeSelected() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DeleteRecipeWidget()));
  }
}
