import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipeParser.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class RecipeWidget extends StatefulWidget {
  RecipeWidget({super.key, required this.currentRecipe});
  Recipe currentRecipe;

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
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
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24'
    ];

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text("Recipe Name:\n  ${widget.currentRecipe.recipeName}"),
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child:
                  Text("Description:\n  ${widget.currentRecipe.description}"),
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: Text("Desired Servings:\n")),
            Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                    items:
                        dropDownNumbers.map<DropdownMenuItem<String>>((number) {
                      return DropdownMenuItem<String>(
                        value: number,
                        child: Text(number),
                      );
                    }).toList(),
                    onChanged: onChangedNumber)),
            // Ingredients goes here
            Align(
              alignment: Alignment.topLeft,
              child: Text("Directions:\n  ${widget.currentRecipe.directions}"),
            ),
            const SizedBox(height: 20, width: 20),
            ElevatedButton(onPressed: goHome, child: const Text("Go Back"))
          ],
        ),
      ),
    );
  }

  void onChangedNumber(String? number) {
    int servingNumber = int.parse(number!);
  }

  void goHome() {
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
  RecipeParser meatSauceParser = RecipeParser(1);
  RecipeParser mashedPotatoesParser = RecipeParser(2);
  RecipeParser chickenSoupParser = RecipeParser(3);
  RecipeParser cookieParser = RecipeParser(4);

  @override
  Widget build(BuildContext context) {
    recipeMap["Meat Sauce"] = createRecipe(meatSauceParser);
    recipeMap["Mashed Potatoes"] = createRecipe(mashedPotatoesParser);
    recipeMap["Chicken Noodle Soup"] = createRecipe(chickenSoupParser);
    recipeMap["Chocolate Chip Cookies"] = createRecipe(cookieParser);
    List recipeList = recipeMap.keys.toList();

    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Cookbook!"),
      DropdownButton(
          items: recipeList.map<DropdownMenuItem<String>>((recipeName) {
            return DropdownMenuItem<String>(
              value: recipeName,
              child: Text(recipeName),
            );
          }).toList(),
          onChanged: onChanged)
    ])));
  }

  void onChanged(String? recipe) {
    Recipe currentRecipe = recipeMap[recipe];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecipeWidget(
                  currentRecipe: currentRecipe,
                )));
  }

  Recipe createRecipe(RecipeParser parser) {
    String name = parser.nameRetriever();
    String description = parser.descriptionRetriever();
    List<Ingredient> ingredients = parser.ingredientRetriever();
    String directions = parser.directionRetriever();

    Recipe recipe = Recipe(name, description, ingredients, directions);

    return recipe;
  }
}
