import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:fp_recipe_book/recipe.dart";
import "package:fp_recipe_book/ingredient.dart";
import "package:fp_recipe_book/measurement.dart";

class RecipeBookModel extends ChangeNotifier {
  Map<String, Recipe> recipeMap = {};

  RecipeBookModel() {
    recipeMap = {
      "Meat Sauce": Recipe(
          "Meat Sauce",
          "Delicious homemade meat sauce made with ground beef (recipe designed for 8 servings)\nOriginal Serving size before chosen servings size: 1",
          [
            Ingredient("Ground Beef", Measurement("lbs", 0.125)),
            Ingredient("Medium Onion, chopped", Measurement("", 0.125)),
            Ingredient("Clove Garlic, minced", Measurement("", 0.5)),
            Ingredient(
                "Small Green Bell Pepper, diced", Measurement("", 0.125)),
            Ingredient("Canned Diced Tomatoes", Measurement("oz", 3.5)),
            Ingredient("Tomato Sauce", Measurement("oz", 2)),
            Ingredient("Tomato Paste", Measurement("oz", 0.75)),
            Ingredient("Dried Oregano", Measurement("tsp", 0.25)),
            Ingredient("Dried Basil", Measurement("tsp", 0.25)),
            Ingredient("Salt", Measurement("tsp", 0.125)),
            Ingredient("Pepper", Measurement("pinch", 1))
          ],
          "\n\t1: Combine ground beef, onion, garlic, and green pepper in a large saucepan over medium-high heat. Cook and stir until meat is browned and crumbly and vegetables are tender, 5 to 7 minutes. Drain grease.\n2: Stir diced tomatoes, tomato sauce, and tomato paste into the pan. Season with oregano, basil, salt, and pepper. Simmer spaghetti sauce for 1 hour, stirring occasionally.",
          1),
      "Mashed Potatoes": Recipe(
          "Mashed Potatoes",
          "Simple and easy homemade mashed potatoes (recipe designed for 10 servings\nOrginal Serving Size before chosen serving size: 1",
          [
            Ingredient(
              "Russet Potatoes, peeled, cut into quarters",
              Measurement("", 1),
            ),
            Ingredient(
              "Butter (optional)",
              Measurement("tbsp", 0.2),
            ),
            Ingredient(
              "Hot Milk",
              Measurement("tbsp", 1.2),
            ),
            Ingredient(
              "Salt",
              Measurement("tsp", 0.1),
            ),
            Ingredient(
              "Pepper",
              Measurement("pinch", 1),
            )
          ],
          "\n\t1: Place potatoes in large saucepan; add enough water to cover. Add ¾ of the salt. Bring to a boil. Reduce heat to medium-low; cover loosely and boil gently for 15 to 20 minutes or until potatoes break apart easily when pierced with fork. Drain well. \n2: Return potatoes to saucepan; shake saucepan gently over low heat for 1 to 2 minutes to evaporate any excess moisture. \n 3: Mash potatoes with potato masher until no lumps remain. Add butter, pepper and remaining salt; continue mashing, gradually adding enough milk to make potatoes smooth and creamy",
          1),
      "Chicken Noodle Soup": Recipe(
          "Chicken Noodle Soup",
          "Quick and easy chicken noodle soup (recipe designed for 6 servings)\n",
          [
            Ingredient("Butter", Measurement("tbsp", 0.1667)),
            Ingredient("Chopped Onion", Measurement("tsp", 4)),
            Ingredient("Chopped Celery", Measurement("tsp", 4)),
            Ingredient("Chicken Broth", Measurement("oz", 9.67)),
            Ingredient("Vegetable Broth", Measurement("oz", 2.42)),
            Ingredient(
                "Chopped, cooked Chicken Breast", Measurement("lbs", 0.833)),
            Ingredient("Egg Noodles", Measurement("cups", 0.25)),
            Ingredient("Sliced Carrots", Measurement("tsp", 8)),
            Ingredient("Dried Basil", Measurement("tsp", 0.0833)),
            Ingredient("Dried Oregano", Measurement("tsp", 0.0833))
          ],
          "\n\t1: Melt butter in a large pot over medium heat. Add onion and celery and cook until just tender, about 5 minutes. \n2: Add chicken broth, vegetable broth, chicken, egg noodles, carrots, basil, oregano, and salt/pepper (to your taste). Stir to combine and bring to a boil. \n3: Reduce heat and simmer for 20 minutes",
          1),
      "Chocolate Chip Cookies": Recipe(
          "Nestle Chocolate Chip Cookies",
          "Classic Nestle chocolate chip cookies (makes about 2 dozen cookies)\n ",
          [
            Ingredient("All Purpose Flour", Measurement("cups", 2.25)),
            Ingredient("Baking soda", Measurement("tsp", 1)),
            Ingredient("Salt", Measurement("tsp", 1)),
            Ingredient("Butter, softened", Measurement("cups", 1)),
            Ingredient("Granulated Sugar", Measurement("cups", 0.75)),
            Ingredient("Packed Brown Sugar", Measurement("cups", 0.75)),
            Ingredient("Vanilla Extract", Measurement("tsp", 1)),
            Ingredient("Eggs", Measurement("", 2)),
            Ingredient("Chocolate Chips", Measurement("cups", 2)),
          ],
          "1: Preheat oven to 375 degrees F. \n2: Combine flour, baking soda, and salt in small bowl. Beat butter, granulated sugar, brown sugar, and vanilla extract in large mixer bowl until creamy. Add eggs, one at a time, beating well after each addition. Gradually beat in flour mixture. Stir in morsels and nuts (if desired). Drop by rounded tablespoons onto ungreased baking sheets. \n3: Bake for 9 to 11 minutes or until golden brown. Cool on baking sheets for 2 minutes; remove to wire racks to cool completely",
          1)
    };
  }

  void addRecipe(String recipeName, Recipe recipe) {
    recipeMap[recipeName] = recipe;
    notifyListeners();
  }

  void deleteRecipe(String recipeName) {
    if (recipeName != "Meat Sauce" &&
        recipeName != "Mashed Potatoes" &&
        recipeName != "Chicken Noodle Soup" &&
        recipeName != "Chocolate Chip Cookies") {
      recipeMap.remove(recipeName);
      notifyListeners();
    }
  }

  List<String> getRecipeNames() {
    return recipeMap.keys.toList();
  }

  Recipe getRecipeFromName(String recipeName) {
    return recipeMap[recipeName]!;
  }

  Map toJson() {
    List<Recipe> recipeList = recipeMap.values.toList();
    return {"recipeBook": jsonEncode(recipeList)};
  }
}
