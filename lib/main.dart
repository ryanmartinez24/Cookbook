import 'package:flutter/material.dart';
import 'package:fp_recipe_book/recipe.dart';

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
            Text("Recipe Name:${widget.currentRecipe.recipeName}"),
            Text("Description:${widget.currentRecipe.description}"),
            // Ingredients goes here
            Text("Directions:${widget.currentRecipe.directions}"),
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
  Recipe orangeChickenRecipe =
      Recipe("Orange Chicken", "Cook it well", "Yummy orange chicken", []);
  Recipe oreoDirtPie =
      Recipe("Oreo Dirt Pie", "Use lots of dirt", "Yummy oreo dirt pie", []);
  Recipe caesarSalad =
      Recipe("Caesar Salad", "Don't forget lettuce", "Yummy Caesar salad", []);

  @override
  Widget build(BuildContext context) {
    recipeMap["Orange Chicken"] = orangeChickenRecipe;
    recipeMap["Oreo Dirt Pie"] = oreoDirtPie;
    recipeMap["Caesar Salad"] = caesarSalad;
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
}
