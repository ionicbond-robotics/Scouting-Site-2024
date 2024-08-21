// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadLocalStorage() async {
  localStorage = await SharedPreferences.getInstance();
}

SharedPreferences? localStorage;
