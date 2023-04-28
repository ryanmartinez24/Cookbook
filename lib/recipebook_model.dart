import 'dart:convert';
import "package:fp_recipe_book/storage.dart";
import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/recipe.dart";
import "package:fp_recipe_book/ingredient.dart";
import "package:fp_recipe_book/measurement.dart";
import 'package:fp_recipe_book/units_of_volume.dart';

class RecipeBookModel extends ChangeNotifier {
  Map<String, Recipe> _recipeMap = {};
  Storage storage = Storage();

  RecipeBookModel.fromMap(this._recipeMap);

  RecipeBookModel() {
    _recipeMap = {
      "Meat Sauce": Recipe(
          "Meat Sauce",
          "Delicious homemade meat sauce made with ground beef (recipe designed for 8 servings)\nOriginal Serving size before chosen servings size: 1",
          [
            Ingredient(
              "Ground Beef",
              Measurement(0.125, UnitsOfVolume.pounds),
            ),
            Ingredient(
              "Medium Onion, chopped",
              Measurement(0.125, UnitsOfVolume.nothing),
            ),
            Ingredient(
              "Clove Garlic, minced",
              Measurement(0.5, UnitsOfVolume.nothing),
            ),
            Ingredient(
              "Small Green Bell Pepper, diced",
              Measurement(0.125, UnitsOfVolume.nothing),
            ),
            Ingredient(
              "Canned Diced Tomatoes",
              Measurement(3.5, UnitsOfVolume.ounces),
            ),
            Ingredient(
              "Tomato Sauce",
              Measurement(2, UnitsOfVolume.ounces),
            ),
            Ingredient(
              "Tomato Paste",
              Measurement(0.75, UnitsOfVolume.ounces),
            ),
            Ingredient(
              "Dried Oregano",
              Measurement(0.25, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Dried Basil",
              Measurement(0.25, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Salt",
              Measurement(0.125, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Pepper",
              Measurement(1, UnitsOfVolume.pinches),
            ),
          ],
          "\n\t1: Combine ground beef, onion, garlic, and green pepper in a large saucepan over medium-high heat. Cook and stir until meat is browned and crumbly and vegetables are tender, 5 to 7 minutes. Drain grease.\n2: Stir diced tomatoes, tomato sauce, and tomato paste into the pan. Season with oregano, basil, salt, and pepper. Simmer spaghetti sauce for 1 hour, stirring occasionally.",
          1),
      "Mashed Potatoes": Recipe(
          "Mashed Potatoes",
          "Simple and easy homemade mashed potatoes (recipe designed for 10 servings\nOrginal Serving Size before chosen serving size: 1",
          [
            Ingredient(
              "Russet Potatoes, peeled, cut into quarters",
              Measurement(1, UnitsOfVolume.nothing),
            ),
            Ingredient(
              "Butter (optional)",
              Measurement(0.2, UnitsOfVolume.tbsp),
            ),
            Ingredient(
              "Hot Milk",
              Measurement(1.2, UnitsOfVolume.tbsp),
            ),
            Ingredient(
              "Salt",
              Measurement(0.1, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Pepper",
              Measurement(1, UnitsOfVolume.pinches),
            )
          ],
          "\n\t1: Place potatoes in large saucepan; add enough water to cover. Add ¾ of the salt. Bring to a boil. Reduce heat to medium-low; cover loosely and boil gently for 15 to 20 minutes or until potatoes break apart easily when pierced with fork. Drain well. \n2: Return potatoes to saucepan; shake saucepan gently over low heat for 1 to 2 minutes to evaporate any excess moisture. \n 3: Mash potatoes with potato masher until no lumps remain. Add butter, pepper and remaining salt; continue mashing, gradually adding enough milk to make potatoes smooth and creamy",
          1),
      "Chicken Noodle Soup": Recipe(
          "Chicken Noodle Soup",
          "Quick and easy chicken noodle soup (recipe designed for 6 servings)\n",
          [
            Ingredient(
              "Butter",
              Measurement(0.1667, UnitsOfVolume.tbsp),
            ),
            Ingredient(
              "Chopped Onion",
              Measurement(4, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Chopped Celery",
              Measurement(4, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Chicken Broth",
              Measurement(9.67, UnitsOfVolume.ounces),
            ),
            Ingredient(
              "Vegetable Broth",
              Measurement(2.42, UnitsOfVolume.ounces),
            ),
            Ingredient(
              "Chopped, cooked Chicken Breast",
              Measurement(0.833, UnitsOfVolume.pounds),
            ),
            Ingredient(
              "Egg Noodles",
              Measurement(0.25, UnitsOfVolume.cup),
            ),
            Ingredient(
              "Sliced Carrots",
              Measurement(8, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Dried Basil",
              Measurement(0.0833, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Dried Oregano",
              Measurement(0.0833, UnitsOfVolume.tsp),
            ),
          ],
          "\n\t1: Melt butter in a large pot over medium heat. Add onion and celery and cook until just tender, about 5 minutes. \n2: Add chicken broth, vegetable broth, chicken, egg noodles, carrots, basil, oregano, and salt/pepper (to your taste). Stir to combine and bring to a boil. \n3: Reduce heat and simmer for 20 minutes",
          1),
      "Chocolate Chip Cookies": Recipe(
          "Chocolate Chip Cookies",
          "Classic Nestle chocolate chip cookies (makes about 2 dozen cookies)\n ",
          [
            Ingredient(
              "All Purpose Flour",
              Measurement(2.25, UnitsOfVolume.cup),
            ),
            Ingredient(
              "Baking soda",
              Measurement(1, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Salt",
              Measurement(1, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Butter, softened",
              Measurement(1, UnitsOfVolume.cup),
            ),
            Ingredient(
              "Granulated Sugar",
              Measurement(0.75, UnitsOfVolume.cup),
            ),
            Ingredient(
              "Packed Brown Sugar",
              Measurement(0.75, UnitsOfVolume.cup),
            ),
            Ingredient(
              "Vanilla Extract",
              Measurement(1, UnitsOfVolume.tsp),
            ),
            Ingredient(
              "Eggs",
              Measurement(2, UnitsOfVolume.nothing),
            ),
            Ingredient(
              "Chocolate Chips",
              Measurement(2, UnitsOfVolume.cup),
            ),
          ],
          "1: Preheat oven to 375 degrees F. \n2: Combine flour, baking soda, and salt in small bowl. Beat butter, granulated sugar, brown sugar, and vanilla extract in large mixer bowl until creamy. Add eggs, one at a time, beating well after each addition. Gradually beat in flour mixture. Stir in morsels and nuts (if desired). Drop by rounded tablespoons onto ungreased baking sheets. \n3: Bake for 9 to 11 minutes or until golden brown. Cool on baking sheets for 2 minutes; remove to wire racks to cool completely",
          1),
    };
  }

  void addRecipe(String recipeName, Recipe recipe) {
    _recipeMap[recipeName] = recipe;
    storage.writeRecipes(jsonEncode(toJson()));
    notifyListeners();
  }

  void deleteRecipe(String recipeName) {
    _recipeMap.remove(recipeName);
    storage.writeRecipes(jsonEncode(toJson()));
    notifyListeners();
  }

  List<String> getRecipeNames() {
    return _recipeMap.keys.toList();
  }

  Recipe getRecipeFromName(String recipeName) {
    return _recipeMap[recipeName]!;
  }

  Map<String, Recipe> getMap() {
    return _recipeMap;
  }

  void updateMap(Map<String, Recipe> updatedMap) {
    _recipeMap = updatedMap;
  }

  Map<String, Recipe> getRecipeMap() {
    return _recipeMap;
  }

  Map toJson() {
    List<Recipe> recipeList = _recipeMap.values.toList();
    return {"recipeBook": jsonEncode(recipeList)};
  }

  factory RecipeBookModel.fromJson(dynamic json) {
    Map<String, Recipe> recipeMap = {};
    var recipeBookJson = jsonDecode(json["recipeBook"]);
    List<dynamic> recipes = recipeBookJson
        .map((recipeJson) => Recipe.fromJson(recipeJson))
        .toList();

    for (Recipe recipe in recipes) {
      recipeMap[recipe.recipeName] = recipe;
    }
    return RecipeBookModel.fromMap(recipeMap);
  }
}
