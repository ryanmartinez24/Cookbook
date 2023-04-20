import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/ingredient_change_notifier.dart';
import "package:provider/provider.dart";

class AddIngredientWidget extends StatefulWidget {
  const AddIngredientWidget({super.key});

  @override
  State<AddIngredientWidget> createState() => AddIngredientWidgetState();
}

class AddIngredientWidgetState extends State<AddIngredientWidget> {
  List<FieldEntryWidget> _fieldWidgetList = [];
  List<String> _enteredUnits = [];
  List<String> _enteredIngredientNames = [];
  List<int> _enteredAmount = [];
  List<Ingredient> _ingredients = [];
  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: _fieldWidgetList.length,
        itemBuilder: (_, index) => _fieldWidgetList[index],
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

  void addFieldEntryWidget() {
    if (_enteredUnits.isNotEmpty) {
      _enteredUnits = [];
      _enteredIngredientNames = [];
      _enteredAmount = [];
      _fieldWidgetList = [];
    }
    setState(() {});
    _fieldWidgetList.add(FieldEntryWidget());
  }

  void removeFieldEntryWidget() {
    if (_fieldWidgetList.isNotEmpty) {
      _fieldWidgetList.removeLast();
    }
    setState(() {});
  }

  void submitIngredients() {
    _ingredients = [];
    for (FieldEntryWidget currWidget in _fieldWidgetList) {
      _ingredients.add(Ingredient(
          currWidget.nameController.text,
          Measurement(currWidget.unitController.text,
              double.parse(currWidget.amountController.text))));
    }
    Provider.of<IngredientChangeNotifier>(context, listen: false)
        .setIngredients(_ingredients);
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
