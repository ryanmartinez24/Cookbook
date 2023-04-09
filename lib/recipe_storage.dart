import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeStorage {
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> recipeList = [];
    Map<String, Recipe> newRecipeMap = {};
    if (preferences.getStringList('recipeList') != null) {
      recipeList = preferences.getStringList('recipeList');
      for (int i = 0; i < recipeList.length; i++) {}
    }
  }

  addData(recipeList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('recipeList', recipeList);
  }

  /*
  void checkLocalStorage() async {
    Map<String, Recipe> newRecipeMap = {};
    String storedRecipes = await readContent();

    if (storedRecipes.isNotEmpty) {
      newRecipeMap = jsonDecode(storedRecipes).fromJson();
      Provider.of<RecipesModel>(context).updateRecipeMap(newRecipeMap);
    }
  }

  Future<void> writeToLocalStorage() async {
    Map<String, dynamic> recipeStorage =
        Provider.of<RecipesModel>(context).toJson();
    final file = await localFile;
    file.writeAsString('$recipeStorage');
  }

  Future<String> readContent() async {
    try {
      final file = await localFile;

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'Local Storage is empty';
    }
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/data.txt');
  }

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  */
}
