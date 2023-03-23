import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement_converter.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipe_parser.dart';
import 'package:fp_recipe_book/ingredient_display.dart';
import 'package:fp_recipe_book/serving_scaler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class RecipeWidget extends StatefulWidget {
  const RecipeWidget({super.key, required this.currentRecipe});
  final Recipe currentRecipe;

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  late IngredientDisplay ingredientDisplay =
      IngredientDisplay(widget.currentRecipe.ingredients);
  @override
  Widget build(BuildContext context) {
    const List<String> dropDownNumbers = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '12',
      '14',
      '16',
      '18',
      '20',
      '22',
      '24'
    ];

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
                      child: DropdownButton(
                          items: dropDownNumbers
                              .map<DropdownMenuItem<String>>((number) {
                            return DropdownMenuItem<String>(
                              value: number,
                              child: Text(number),
                            );
                          }).toList(),
                          onChanged: _onServingChosen)),
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
                child: Text("\n${ingredientDisplay.display()}"),
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
          ElevatedButton(onPressed: _goHome, child: const Text("Go Back"))
        ],
      )),
    );
  }

  void _onServingChosen(String? number) {
    double servingNumber = double.parse(number!);
    setState(() {
      List<Ingredient> ingredients = widget.currentRecipe.ingredients;
      ServingScaler scaler = ServingScaler(ingredients);
      MeasurementConverter converter = MeasurementConverter();
      double scaleFactor = servingNumber / widget.currentRecipe.scale;
      List<Ingredient> ingredientsScaled = scaler.amountScaler(scaleFactor);
      ingredientsScaled = converter.convertIngredients(ingredientsScaled);
      widget.currentRecipe.ingredients = ingredientsScaled;
      widget.currentRecipe.scale = servingNumber;
    });
  }

  void _goHome() {
    Navigator.pop(context);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map recipeMap = {};

  @override
  Widget build(BuildContext context) {
    recipeMap["Meat Sauce"] = _createRecipe(meatSauceParser);
    recipeMap["Mashed Potatoes"] = _createRecipe(mashedPotatoesParser);
    recipeMap["Chicken Noodle Soup"] = _createRecipe(chickenSoupParser);
    recipeMap["Chocolate Chip Cookies"] = _createRecipe(cookieParser);
    List recipeList = recipeMap.keys.toList();

    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          onChanged: _onRecipeSelected)
    ])));
  }

  void _onRecipeSelected(String? recipe) {
    Recipe currentRecipe = recipeMap[recipe];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecipeWidget(
                  currentRecipe: currentRecipe,
                )));
  }

  Recipe _createRecipe(RecipeParser parser) {
    return;
  }
}
