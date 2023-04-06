import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt');
}

Future<String?> readContent() async {
  try {
    final file = await _localFile;

    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return null;
  }
}
