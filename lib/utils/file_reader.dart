import 'package:flutter/services.dart' show rootBundle;

Future<String> readJson(String filename) async {
  return await rootBundle.loadString('assets/response/$filename.json');
}
