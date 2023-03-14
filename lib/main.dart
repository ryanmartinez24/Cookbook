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

class recipeWidget extends StatefulWidget {
  recipeWidget({super.key, required this.currentRecipe});
  Recipe currentRecipe;

  @override
  State<recipeWidget> createState() => _recipeWidgetState();
}

class _recipeWidgetState extends State<recipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Recipe Name:  ${widget.currentRecipe.recipeName}"),
            const SizedBox(height: 20),
            Text("Description:  ${widget.currentRecipe.description}"),
            const SizedBox(height: 20),
            // Ingredients goes here
            Text("Directions:  ${widget.currentRecipe.directions}"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: goHome, child: const Text("Go Back"))
          ],
        ),
      ),
    );
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

  void onChanged(String? s) {
    Recipe currentRecipe = recipeMap[s];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => recipeWidget(
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
