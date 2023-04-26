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
  final List<FieldEntryWidget> fieldWidgetList = [];
  final List<String> enteredUnits = [];
  final List<String> enteredIngredientNames = [];
  final List<int> enteredAmount = [];
  final List<Ingredient> ingredients = [];
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
              const SizedBox(
                width: 220,
              ),
              ElevatedButton(
                onPressed: removeFieldEntryWidget,
                child: const Text("Remove an ingredient"),
              ),
            ],
          ),
          dynamicTextField
        ],
      ),
    );
  }

  void addFieldEntryWidget() {
    if (enteredUnits.isNotEmpty) {
      enteredUnits.clear();
      enteredIngredientNames.clear();
      enteredAmount.clear();
      fieldWidgetList.clear();
    }
    setState(() {});
    fieldWidgetList.add(const FieldEntryWidget());
  }

  void removeFieldEntryWidget() {
    if (fieldWidgetList.isNotEmpty) {
      fieldWidgetList.removeLast();
    }
    setState(() {});
  }

  void submitIngredients() {
    for (FieldEntryWidget currWidget in fieldWidgetList) {
      ingredients.add(currWidget.createIngredient);
    }
    Provider.of<IngredientChangeNotifier>(context, listen: false)
        .setIngredients(ingredients);
  }
}

class FieldEntryWidget extends StatefulWidget {
  const FieldEntryWidget({
    super.key,
  });

  get createIngredient => _FieldEntryWidgetState().createIngredient();

  @override
  State<FieldEntryWidget> createState() => _FieldEntryWidgetState();
}

class _FieldEntryWidgetState extends State<FieldEntryWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _givenName = '';
  String _chosenUnit = '';
  String _givenAmount = '';

  final List<DropdownMenuItem<String>> _possibleUnits = [
    const DropdownMenuItem(value: 'pinch', child: Text('pinch')),
    const DropdownMenuItem(value: 'tsp', child: Text('tsp')),
    const DropdownMenuItem(value: 'tbsp', child: Text('tbsp')),
    const DropdownMenuItem(value: 'cups', child: Text('cups')),
    const DropdownMenuItem(value: 'pints', child: Text('pints')),
    const DropdownMenuItem(value: 'quarts', child: Text('quarts')),
    const DropdownMenuItem(value: 'gallons', child: Text('gallons')),
  ];

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
                  onChanged: (value) => _onNameChanged(value),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Ingredient Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButton(
                  items: _possibleUnits,
                  onChanged: (value) {
                    setState(() {
                      _chosenUnit = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  onChanged: (value) {
                    _onAmountChanged(value);
                  },
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount of Ingredient",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () => Provider.of<IngredientChangeNotifier>(
                          context,
                          listen: false)
                      .addIngredient(createIngredient()),
                  child: const Text("Submit Ingredient")),
            ],
          ),
        ],
      ),
    );
  }

  Ingredient createIngredient() {
    String name = _givenName;
    String unit = _chosenUnit;
    double amount = double.parse(_givenAmount);
    Ingredient currentIngredient = Ingredient(name, Measurement(unit, amount));

    return currentIngredient;
  }

  _onAmountChanged(value) {
    setState(() {
      _givenAmount = value;
    });
  }

  _onNameChanged(value) {
    setState(() {
      _givenName = value;
    });
  }
}
