//makes recipe objects from json information
//takes json
//stores the keys as variables
//decode method
//encode method
import 'dart:convert';

class Recipe {
  late final jsonData;
  late String string;

  Recipe(this.jsonData) {
    jsonDecoder();
  }

  String jsonDecoder() {
    string = jsonData.decode();
    return string;
  }
}
