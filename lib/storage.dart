import "dart:io";
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recipeData.txt');
  }

  Future<File> writeRecipes(String data) async {
    final file = await _localFile;

    return file.writeAsString(data);
  }

  Future<String> readRecipes() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (exception) {
      return "";
    }
  }
}
