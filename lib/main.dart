import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scouting_site/pages/auto_page.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  loadLocalStorage();
  runApp(const ScoutingSite());
}

class ScoutingSite extends StatelessWidget {
  const ScoutingSite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Site',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'FRC-Scouting'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> teams = ["Ionic Bond #9738", "Bumblebee #3399"];
  String? _event, _scouterName;
  int? _scoutedTeam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 5),
            DialogTextInput(
              label: "Scouter name",
              onSubmit: (value) {
                _scouterName = value;
              },
              initialText: _scouterName,
            ),
            const SizedBox(height: 5),
            DialogTextInput(
              label: "Team #",
              onSubmit: (value) {
                _scoutedTeam = int.parse(value);
              },
            ),
            const SizedBox(height: 5),
            DialogTextInput(
              onSubmit: (value) {
                _event = value;
              },
              label: "Event #",
              initialText: _event?.toString(),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                tooltip: "Auto-Fill",
                child: const Icon(Icons.auto_fix_normal),
                onPressed: () async {
                  setState(() {
                    // _event = localStorage?.getString("event");
                    // _scouterName = localStorage?.getString("scouter");
                    // _scoutedTeam = localStorage?.getInt("scoutedTeam");
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              FloatingActionButton(
                tooltip: "Scout",
                child: const Icon(Icons.login_outlined),
                onPressed: () async {
                  localStorage?.setString("event", _event ?? "");
                  localStorage?.setString("scouter", _scouterName ?? "");
                  localStorage?.setInt("scoutedTeam", _scoutedTeam ?? 0);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AutonomousPage()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
