import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fp_recipe_book/ingredient.dart';
import 'package:fp_recipe_book/measurement.dart';
import 'package:fp_recipe_book/ingredient_change_notifier.dart';
import 'package:fp_recipe_book/units_of_volume.dart';
import "package:provider/provider.dart";

class IngredientEntryWidget extends StatefulWidget {
  const IngredientEntryWidget({
    super.key,
    required this.onIngredientCreated,
  });

  final void Function() onIngredientCreated;

  @override
  State<IngredientEntryWidget> createState() => IngredientEntryWidgetState();
}

class IngredientEntryWidgetState extends State<IngredientEntryWidget> {
  final List<IngredientWidget> fieldWidgetList = [];
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
    fieldWidgetList.add(IngredientWidget(
      onIngredientCreated: widget.onIngredientCreated,
    ));
  }

  void removeFieldEntryWidget() {
    if (fieldWidgetList.isNotEmpty) {
      fieldWidgetList.removeLast();
    }
    setState(() {});
  }

  void submitIngredients() {
    for (IngredientWidget currWidget in fieldWidgetList) {
      ingredients.add(currWidget.createIngredient);
    }
    Provider.of<IngredientChangeNotifier>(context, listen: false)
        .setIngredients(ingredients);
  }
}

class IngredientWidget extends StatefulWidget {
  const IngredientWidget({super.key, required this.onIngredientCreated});

  final void Function() onIngredientCreated;

  get createIngredient => _IngredientWidgetState().createIngredient();

  @override
  State<IngredientWidget> createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _givenName = '';
  String _chosenUnit = '';
  String _givenAmount = '';
  bool _hasEnteredUnit = false;
  bool _hasEnteredName = false;
  bool _hasEnteredAmount = false;
  bool _hasSubmitted = false;

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
                  onChanged: (value) => _onUnitChanged(value),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  onChanged: (value) => _onAmountChanged(value),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount of Ingredient",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: _hasEnteredAmount &&
                          _hasEnteredName &&
                          _hasEnteredUnit &&
                          !_hasSubmitted
                      ? () {
                          setState(() {
                            _hasSubmitted = true;
                          });
                          widget.onIngredientCreated();
                          Provider.of<IngredientChangeNotifier>(context,
                                  listen: false)
                              .addIngredient(createIngredient());
                        }
                      : null,
                  child: const Text("Submit Ingredient")),
            ],
          ),
        ],
      ),
    );
  }

  Ingredient createIngredient() {
    String name = _givenName;
    UnitsOfVolume unit = _findUnit();
    double amount = double.parse(_givenAmount);
    Ingredient currentIngredient = Ingredient(name, Measurement(amount, unit));

    return currentIngredient;
  }

  _onUnitChanged(value) {
    setState(() {
      _chosenUnit = value;
      _hasEnteredUnit = true;
    });
  }

  UnitsOfVolume _findUnit() {
    List<String> units = [
      'pinch',
      'tsp',
      'tbsp',
      'cups',
      'pints',
      'quarts',
      'gallons',
    ];

    UnitsOfVolume unit = UnitsOfVolume.pinches;
    for (int i = 1; i < 7; i++) {
      if (_chosenUnit == units[i]) {
        unit = UnitsOfVolume.values[i];
      }
    }

    return unit;
  }

  void _onAmountChanged(value) {
    setState(() {
      _givenAmount = value;
      _hasEnteredAmount = true;
    });
  }

  void _onNameChanged(value) {
    setState(() {
      _givenName = value;
      _hasEnteredName = true;
    });
  }
}
