import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:fp_recipe_book/recipebook_model.dart';

class DeleteRecipeWidget extends StatefulWidget {
  const DeleteRecipeWidget({super.key});

  @override
  State<DeleteRecipeWidget> createState() => _DeleteRecipeWidgetState();
}

class _DeleteRecipeWidgetState extends State<DeleteRecipeWidget> {
  bool _hasSelectRecipe = false;
  String? selectedRecipe = '';

  @override
  Widget build(BuildContext context) {
    List recipeList = Provider.of<RecipeBookModel>(context).getRecipeNames();

    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Delete an existing Recipe!"),
      DropdownButton(
        items: recipeList.map<DropdownMenuItem<String>>((recipeName) {
          return DropdownMenuItem<String>(
            value: recipeName,
            child: Text(recipeName),
          );
        }).toList(),
        onChanged: (recipeName) => _dropdownCallback(recipeName!),
      ),
      ElevatedButton(
        onPressed: _hasSelectRecipe
            ? () {
                _onButtonPressed();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Deleting Recipe...'),
                    content: const Text('The chosen recipe has been deleted'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            : null,
        child: const Text('Submit'),
      ),
      const Divider(),
      ElevatedButton(onPressed: _goHome, child: const Text("Homepage")),
    ])));
  }

  void _dropdownCallback(String selectedValue) {
    setState(() {
      selectedValue = selectedValue;
      _hasSelectRecipe = true;
    });
  }

  void _onButtonPressed() {
    if (selectedRecipe is String) {
      Provider.of<RecipeBookModel>(context, listen: false)
          .deleteRecipe(selectedRecipe!);
      print('Action completed!');
    }

    setState(() {
      _hasSelectRecipe = false;
    });
  }

  void _goHome() {
    Navigator.pop(context);
  }
}
