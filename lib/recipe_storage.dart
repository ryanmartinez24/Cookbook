import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fp_recipe_book/recipe.dart';
import 'package:fp_recipe_book/recipes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RecipeStorage {
  BuildContext context;

  RecipeStorage(this.context);

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
    final file = await _localFile;
    file.writeAsString('$recipeStorage');
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'Local Storage is empty';
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
