import 'package:flutter/services.dart';

Future<String> loadMapStyle() async {
  return await rootBundle.loadString('assets/dark_map_style.json');
}
