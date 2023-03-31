import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'measurement.dart';

void main() {
  runApp(const MyApp());
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
      home: MyHomePage(title: 'Flutter Demo Home Page', recipeMap: {}),
    );
  }
}

class AddRecipeWidget extends StatefulWidget {
  AddRecipeWidget({super.key, required this.recipeMap, required this.update});
  Map recipeMap;
  final ValueChanged update;

  @override
  State<AddRecipeWidget> createState() => _AddRecipeWidgetState();
}

class _AddRecipeWidgetState extends State<AddRecipeWidget> {
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
    widget.recipeMap[recipeName] = newRecipe;
  }

  void _goHome() {
    Navigator.pop(context);
    widget.update(widget.recipeMap);
  }
}

class AddIngredientWidget extends StatefulWidget {
  AddIngredientWidget(
      {super.key, required this.ingredients, required this.update});
  List<Ingredient> ingredients;
  final ValueChanged update;

  @override
  State<AddIngredientWidget> createState() => AddIngredientWidgetState();
}

class AddIngredientWidgetState extends State<AddIngredientWidget> {
  List<FieldEntryWidget> fieldWidgetList = [];
  List<String> enteredUnits = [];
  List<String> enteredIngredientNames = [];
  List<int> enteredAmount = [];
  List<Ingredient> ingredients = [];
  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: fieldWidgetList.length,
        itemBuilder: (_, index) => fieldWidgetList[index],
      ),
    );

    return SizedBox(
      height: 250,
      width: 1000,
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: addFieldEntryWidget,
                child: const Text("Add another ingredient"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: removeFieldEntryWidget,
                child: const Text("Remove an ingredient"),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: submitIngredients,
                  child: const Text("Submit Ingredients")),
            ],
          ),
          dynamicTextField
        ],
      ),
    );
  }

  void submitIngredients() {
    ingredients = [];
    for (FieldEntryWidget currWidget in fieldWidgetList) {
      ingredients.add(Ingredient(
          currWidget.nameController.text,
          Measurement(currWidget.unitController.text,
              double.parse(currWidget.amountController.text))));
    }
    widget.update(ingredients);
  }

  void addFieldEntryWidget() {
    if (enteredUnits.isNotEmpty) {
      enteredUnits = [];
      enteredIngredientNames = [];
      enteredAmount = [];
      fieldWidgetList = [];
    }
    setState(() {});
    fieldWidgetList.add(FieldEntryWidget());
  }

  void removeFieldEntryWidget() {
    if (fieldWidgetList.isNotEmpty) {
      fieldWidgetList.removeLast();
    }
    setState(() {});
  }
}

class FieldEntryWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  FieldEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Ingredient Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: unitController,
                  decoration: const InputDecoration(
                    labelText: "Unit Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount of Ingredient",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
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
          ElevatedButton(onPressed: _goHome, child: const Text("Go Back"))
        ],
      )),
    );
  }

  void _onServingChosen(String? number) {
    double servingNumber = double.parse(number!);
    setState(() {
      double scaleFactor = servingNumber / widget.currentRecipe.scale;
      widget.currentRecipe.scaleIngredients(scaleFactor);
      widget.currentRecipe.scale = servingNumber;
    });
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
  MyHomePage({super.key, required this.title, required this.recipeMap});
  final String title;
  Map recipeMap;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Map recipeMap = widget.recipeMap;

    Recipe meatSauceRecipe = Recipe(
        "Meat Sauce",
        "Delicious homemade meat sauce made with ground beef (recipe designed for 8 servings)\nOriginal Serving size before chosen servings size: 1",
        _createMeatSauceIngredientList(),
        "\n\t1: Combine ground beef, onion, garlic, and green pepper in a large saucepan over medium-high heat. Cook and stir until meat is browned and crumbly and vegetables are tender, 5 to 7 minutes. Drain grease.\n2: Stir diced tomatoes, tomato sauce, and tomato paste into the pan. Season with oregano, basil, salt, and pepper. Simmer spaghetti sauce for 1 hour, stirring occasionally.",
        1);

    Recipe mashedPotatoesRecipe = Recipe(
        "Mashed Potatoes",
        "Simple and easy homemade mashed potatoes (recipe designed for 10 servings\nOrginal Serving Size before chosen serving size: 1",
        _createMashedPotatoesIngredientList(),
        "\n\t1: Place potatoes in large saucepan; add enough water to cover. Add ¾ of the salt. Bring to a boil. Reduce heat to medium-low; cover loosely and boil gently for 15 to 20 minutes or until potatoes break apart easily when pierced with fork. Drain well. \n2: Return potatoes to saucepan; shake saucepan gently over low heat for 1 to 2 minutes to evaporate any excess moisture. \n 3: Mash potatoes with potato masher until no lumps remain. Add butter, pepper and remaining salt; continue mashing, gradually adding enough milk to make potatoes smooth and creamy",
        1);

    Recipe chickenNoodleSoupRecipe = Recipe(
        "Chicken Noodle Soup",
        "Quick and easy chicken noodle soup (recipe designed for 6 servings)\nOriginal Serving size before chosen servings size: 1",
        _createChickenNoodleSoupIngredientList(),
        "\n\t1: Melt butter in a large pot over medium heat. Add onion and celery and cook until just tender, about 5 minutes. \n2: Add chicken broth, vegetable broth, chicken, egg noodles, carrots, basil, oregano, and salt/pepper (to your taste). Stir to combine and bring to a boil. \n3: Reduce heat and simmer for 20 minutes",
        1);

    Recipe cookieRecipe = Recipe(
        "Nestle Chocolate Chip Cookies",
        "Classic Nestle chocolate chip cookies (makes about 2 dozen cookies)\nOriginal Serving size before chosen servings size: 1",
        _createCookieIngredientList(),
        "1: Preheat oven to 375 degrees F. \n2: Combine flour, baking soda, and salt in small bowl. Beat butter, granulated sugar, brown sugar, and vanilla extract in large mixer bowl until creamy. Add eggs, one at a time, beating well after each addition. Gradually beat in flour mixture. Stir in morsels and nuts (if desired). Drop by rounded tablespoons onto ungreased baking sheets. \n3: Bake for 9 to 11 minutes or until golden brown. Cool on baking sheets for 2 minutes; remove to wire racks to cool completely",
        1);

    recipeMap["Meat Sauce"] = meatSauceRecipe;
    recipeMap["Mashed Potatoes"] = mashedPotatoesRecipe;
    recipeMap["Chicken Noodle Soup"] = chickenNoodleSoupRecipe;
    recipeMap["Chocolate Chip Cookies"] = cookieRecipe;
    List recipeList = recipeMap.keys.toList();

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
          ],
        ),
      ),
    );
  }

  void _onRecipeSelected(String? recipe) {
    Recipe currentRecipe = widget.recipeMap[recipe];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecipeWidget(
                  currentRecipe: currentRecipe,
                )));
  }

  void _update(Map recipeMap) {
    setState(() {});
  }

  void _onCreateRecipeSelected() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRecipeWidget(
            recipeMap: widget.recipeMap,
            update: (recipeMap) => _update(widget.recipeMap)),
      ),
    );
  }

  List<Ingredient> _createMeatSauceIngredientList() {
    List<Ingredient> meatSauceIngredients = [
      Ingredient("Ground Beef", Measurement("lbs", 0.125)),
      Ingredient("Medium Onion, chopped", Measurement("", 0.125)),
      Ingredient("Clove Garlic, minced", Measurement("", 0.5)),
      Ingredient("Small Green Bell Pepper, diced", Measurement("", 0.125)),
      Ingredient("Canned Diced Tomatoes", Measurement("oz", 3.5)),
      Ingredient("Tomato Sauce", Measurement("oz", 2)),
      Ingredient("Tomato Paste", Measurement("oz", 0.75)),
      Ingredient("Dried Oregano", Measurement("tsp", 0.25)),
      Ingredient("Dried Basil", Measurement("tsp", 0.25)),
      Ingredient("Salt", Measurement("tsp", 0.125)),
      Ingredient("Pepper", Measurement("pinch", 1))
    ];

    return meatSauceIngredients;
  }

  List<Ingredient> _createMashedPotatoesIngredientList() {
    List<Ingredient> mashedPotatoesIngredients = [
      Ingredient(
          "Russet Potatoes, peeled, cut into quarters", Measurement("", 1)),
      Ingredient("Butter (optional)", Measurement("tbsp", 0.2)),
      Ingredient("Hot Milk", Measurement("tbsp", 1.2)),
      Ingredient("Salt", Measurement("tsp", 0.1)),
      Ingredient("Pepper", Measurement("pinch", 1))
    ];

    return mashedPotatoesIngredients;
  }

  List<Ingredient> _createChickenNoodleSoupIngredientList() {
    List<Ingredient> chickenSoupIngredients = [
      Ingredient("Butter", Measurement("tbsp", 0.1667)),
      Ingredient("Chopped Onion", Measurement("tsp", 4)),
      Ingredient("Chopped Celery", Measurement("tsp", 4)),
      Ingredient("Chicken Broth", Measurement("oz", 9.67)),
      Ingredient("Vegetable Broth", Measurement("oz", 2.42)),
      Ingredient("Chopped, cooked Chicken Breast", Measurement("lbs", 0.833)),
      Ingredient("Egg Noodles", Measurement("cups", 0.25)),
      Ingredient("Sliced Carrots", Measurement("tsp", 8)),
      Ingredient("Dried Basil", Measurement("tsp", 0.0833)),
      Ingredient("Dried Oregano", Measurement("tsp", 0.0833))
    ];

    return chickenSoupIngredients;
  }

  List<Ingredient> _createCookieIngredientList() {
    List<Ingredient> cookieIngredients = [
      Ingredient("All Purpose Flour", Measurement("cups", 2.25)),
      Ingredient("Baking soda", Measurement("tsp", 1)),
      Ingredient("Salt", Measurement("tsp", 1)),
      Ingredient("Butter, softened", Measurement("cups", 1)),
      Ingredient("Granulated Sugar", Measurement("cups", 0.75)),
      Ingredient("Packed Brown Sugar", Measurement("cups", 0.75)),
      Ingredient("Vanilla Extract", Measurement("tsp", 1)),
      Ingredient("Eggs", Measurement("", 2)),
      Ingredient("Chocolate Chips", Measurement("cups", 2)),
    ];

    return cookieIngredients;
  }
}
