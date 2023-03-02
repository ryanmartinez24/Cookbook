import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class recipeWidget extends StatefulWidget {
  const recipeWidget({super.key});

  @override
  State<recipeWidget> createState() => _recipeWidgetState();
}

class _recipeWidgetState extends State<recipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [ElevatedButton(onPressed: goHome, child: Text("Go Back"))],
        ),
      ),
    );
  }

  void goHome() {
    Navigator.pop(context);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> strings = [
      DropdownMenuItem(
        value: "Orange Chicken",
        child: Text("Orange Chicken"),
        onTap: onTapOrangeChicken,
      ),
      const DropdownMenuItem(
          value: "Oreo Dirt Pie", child: Text("Oreo Dirt Pie")),
      const DropdownMenuItem(
        value: "Caesar Salad",
        child: Text("Caesar Salad,"),
      ),
    ];
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          const Text("Cookbook!"),
          DropdownButton(items: strings, onChanged: onChanged)
        ])));
  }

  void onTapOrangeChicken() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => recipeWidget()),
    );
  }

  void onChanged(String? s) {
    //To-Do
  }
}
