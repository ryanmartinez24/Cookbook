import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/new_recipe_model.dart';
import "package:provider/provider.dart";

class AddIngredientWidget extends StatefulWidget {
  const AddIngredientWidget({super.key});

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
    Provider.of<NewRecipeModel>(context, listen: false)
        .setIngredients(ingredients);
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
