import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<dynamic>> loadJsonData() async {
  final String jsonString = await rootBundle.loadString('assets/food_database.json');
  return jsonDecode(jsonString);
}
