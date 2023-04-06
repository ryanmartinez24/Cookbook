import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:fp_recipe_book/recipes_model.dart';

class DeleteRecipeWidget extends StatefulWidget{
  const DeleteRecipeWidget({super.key});

  @override
  State<DeleteRecipeWidget> createState() => _DeleteRecipeWidgetState();
}

class _DeleteRecipeWidgetState extends State<DeleteRecipeWidget> {
  @override
  Widget build(BuildContext context){
      List recipeList = Provider.of<RecipesModel>(context).getRecipeNames();

    return Scaffold(
      body: Column(
        children: [
          const Text("Delete an existing Recipe!"),
          const Spacer(),
          DropdownButton(
              items: recipeList.map<DropdownMenuItem<String>>((recipeName) {
                return DropdownMenuItem<String>(
                  value: recipeName,
                  child: Text(recipeName),
                );
              }).toList(),
              onChanged: (recipeName) => Provider.of<RecipesModel>(context, listen: false).deleteRecipe(recipeName!),
          ),
          ElevatedButton(onPressed: _goHome, child: const Text("Homepage")),
        ]
      )
    );
  }
  void _goHome() {
    Navigator.pop(context);
  }
}

