// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Project imports:
import 'package:scouting_site/pages/summation/scouting_entries_page.dart';
import 'package:scouting_site/services/formatters/text_formatter_builder.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/services/scouting/scouting.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';

class ScoutingSite extends StatelessWidget {
  const ScoutingSite({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    bool isDarkMode = brightness == Brightness.dark;
    GlobalColors.primaryColor = isDarkMode ? Colors.black : Colors.white;

    return MaterialApp(
      title: 'Scouting Site',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: GlobalColors.primaryColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
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
  List<String> teams = [];
  final _scouterController = TextEditingController();
  final _gameController = TextEditingController();
  String? _selectedTeam;

  @override
  void initState() {
    Scouting.data.game = 0;
    super.initState();
    _scouterController.text = Scouting.data.scouter ?? '';
    _gameController.text = Scouting.data.game?.toString() ?? '';
    _selectedTeam = Scouting.data.scoutedTeam;
  }

  @override
  Widget build(BuildContext context) {
    if (Scouting.data.game != null) {
      List<String> gameTeams = [];

      var (redAlliance, blueAlliance) = Scouting.matchesTeamsPair();
      redAlliance[Scouting.data.game]?.forEach((team) => gameTeams.add(team));
      blueAlliance[Scouting.data.game]?.forEach((team) => gameTeams.add(team));

      teams = gameTeams;
    } else {
      var (redAlliance, blueAlliance) = Scouting.matchesTeamsPair();

      for (var game in redAlliance.keys) {
        teams.addAll(redAlliance[game] ?? []);
        teams.addAll(blueAlliance[game] ?? []);
      }
    }

    bool isRedAllianceTeamSelected =
        teams.indexOf(Scouting.data.scoutedTeam?.split(" ")[0] ?? "0") < 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.appBarColor,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: GlobalColors.teamColor,
          ),
        ),
      ),
      body: Container(
        color: GlobalColors.backgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 5),
            DialogTextInput(
              label: "Scouter name",
              textEditingController: _scouterController,
              onSubmit: (value) {
                Scouting.data.scouter = value;
              },
              initialText: Scouting.data.scouter,
            ),
            const SizedBox(height: 5),
            DropdownMenu<String>(
              label: const Text(
                "Scouting On",
              ),
              initialSelection: Scouting.data.scoutedTeam,
              onSelected: (value) {
                setState(() {
                  _selectedTeam = value.toString();
                  Scouting.data.scoutedTeam = _selectedTeam;
                });
              },
              textStyle: TextStyle(
                color: isRedAllianceTeamSelected
                    ? Colors.redAccent
                    : Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
              dropdownMenuEntries: getTeamDropdownEntries(),
              width: MediaQuery.of(context).size.width - 5,
            ),
            const SizedBox(height: 5),
            DialogTextInput(
              onSubmit: (value) {
                setState(() {
                  Scouting.data.game = int.tryParse(value);
                });
              },
              label: "Game #",
              textEditingController: _gameController,
              formatter: TextFormatterBuilder.integerTextFormatter(),
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
              const SizedBox(
                width: 5,
              ),
              FloatingActionButton(
                tooltip: "Summation",
                child: const Icon(Icons.summarize),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScoutingEntriesPage(),
                    ),
                  );
                },
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 140),
              ),
              FloatingActionButton(
                heroTag: 1,
                tooltip: "Scout",
                child: const Icon(Icons.login_outlined),
                onPressed: () async {
                  final scouterName = _scouterController.text.trim();
                  final gameNumber = _gameController.text.trim();

                  if (scouterName.isEmpty ||
                      _selectedTeam == null ||
                      gameNumber.isEmpty) {
                    // Show an alert if any required field is empty
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Validation Error'),
                          content:
                              const Text('Please fill in all required fields.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  // Save the data if all fields are filled
                  localStorage?.setInt("game", int.parse(gameNumber));
                  localStorage?.setString("scouter", scouterName);
                  localStorage?.setString("scoutedTeam", _selectedTeam ?? "");

                  Scouting.advance(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DropdownMenuEntry<String>> getTeamDropdownEntries() {
    List<DropdownMenuEntry<String>> entries = [];
    if (teams.isNotEmpty) {
      for (int i = 0; i < teams.length; i++) {
        bool blueAlliance = i > 2;
        String labelText =
            "${blueAlliance ? "Blue" : "Red"} ${(i + 1) % 3 == 0 ? 3 : (i + 1) % 3}: ${teams[i]}";
        bool isSelected = i == teams.indexOf(_selectedTeam ?? "");
        entries.add(
          DropdownMenuEntry(
            label: labelText,
            labelWidget: Text(
              labelText,
              style: TextStyle(
                color: blueAlliance ? Colors.blueAccent : Colors.redAccent,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            value: teams[i],
          ),
        );
      }
    }

    return entries;
  }
}
