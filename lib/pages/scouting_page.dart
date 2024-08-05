import 'package:flutter/material.dart';
import 'package:scouting_site/services/formatters/text_formatter_builder.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/services/scouting/scouting.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';

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
  List<String> teams = [
    "Ionic Bond #9738",
    "Bumblebee #3399",
  ];
  String? _scouterName;
  String? _scoutedTeam;
  int? _gameNum;

  @override
  Widget build(BuildContext context) {
    teams.sort((a, b) {
      final int? teamNumberA = _extractTeamNumber(a);
      final int? teamNumberB = _extractTeamNumber(b);

      if (teamNumberA == null || teamNumberB == null) {
        return 0; // Handle cases where the team number cannot be extracted
      }
      return teamNumberA.compareTo(teamNumberB);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
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
            DropdownMenu(
              label: const Text("Scouting On"),
              onSelected: (value) {
                _scoutedTeam = value.toString();
              },
              dropdownMenuEntries: getTeamDropdownEntries(),
              width: MediaQuery.of(context).size.width - 5,
            ),
            const SizedBox(height: 5),
            DialogTextInput(
              onSubmit: (value) {
                _gameNum = int.parse(value);
              },
              label: "Game #",
              initialText: _gameNum?.toString(),
              formatter: TextFormatterBuilder.decimalTextFormatter(),
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
                heroTag: 0,
                tooltip: "Auto-Fill",
                child: const Icon(Icons.auto_fix_normal),
                onPressed: () async {
                  setState(() {
                    // _event = localStorage?.getString("event");
                    _scouterName = localStorage?.getString("scouter");
                    // _scoutedTeam = localStorage?.getInt("scoutedTeam");
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              FloatingActionButton(
                heroTag: 1,
                tooltip: "Scout",
                child: const Icon(Icons.login_outlined),
                onPressed: () async {
                  localStorage?.setInt("game", _gameNum ?? 0);
                  localStorage?.setString("scouter", _scouterName ?? "");
                  localStorage?.setString("scoutedTeam", _scoutedTeam ?? "");
                  Scouting.advance(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  List<DropdownMenuEntry> getTeamDropdownEntries() {
    List<DropdownMenuEntry> entries = [];
    if (teams.isNotEmpty) {
      for (var team in teams) {
        entries.add(DropdownMenuEntry(label: team, value: team));
      }
    }

    return entries;
  }

  int? _extractTeamNumber(String team) {
    final RegExp regExp = RegExp(r'#(\d+)$');
    final match = regExp.firstMatch(team);

    if (match != null && match.groupCount > 0) {
      return int.tryParse(match.group(1) ?? '');
    }
    return null;
  }
}