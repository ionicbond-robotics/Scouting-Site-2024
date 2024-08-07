import 'package:flutter/material.dart';
import 'package:scouting_site/pages/scouting_page.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/services/scouting/scouting.dart';

void main() async {
  loadLocalStorage();
  await Scouting.initialize();
  runApp(const ScoutingSite());
}
