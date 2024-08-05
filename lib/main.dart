import 'package:flutter/material.dart';
import 'package:scouting_site/pages/scouting_page.dart';
import 'package:scouting_site/services/localstorage.dart';

void main() async {
  loadLocalStorage();
  runApp(const ScoutingSite());
}
