import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scouting_site/pages/summation_page.dart';
import 'package:scouting_site/services/formatters/text_formatter_builder.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/services/scouting/helper_methods.dart';
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
  List<String> teams = [
    "Ionic Bond #9738",
    "Bumblebee #3399",
  ];

  final _scouterController = TextEditingController();
  final _gameController = TextEditingController();
  String? _selectedTeam;

  @override
  void initState() {
    super.initState();
    _scouterController.text = Scouting.data.scouter ?? '';
    _gameController.text = Scouting.data.game?.toString() ?? '';
    _selectedTeam = Scouting.data.scoutedTeam;
  }

  @override
  Widget build(BuildContext context) {
    teams.sort((a, b) {
      final int teamNumberA = extractNumber(a);
      final int teamNumberB = extractNumber(b);

      if (teamNumberA == 0 || teamNumberB == 0) {
        return 0; // Handle cases where the team number cannot be extracted
      }
      return teamNumberA.compareTo(teamNumberB);
    });

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
            DropdownMenu(
              label: const Text("Scouting On"),
              initialSelection: Scouting.data.scoutedTeam,
              onSelected: (value) {
                setState(() {
                  _selectedTeam = value.toString();
                  Scouting.data.scoutedTeam = _selectedTeam;
                });
              },
              dropdownMenuEntries: getTeamDropdownEntries(),
              width: MediaQuery.of(context).size.width - 5,
            ),
            const SizedBox(height: 5),
            DialogTextInput(
              onSubmit: (value) {
                Scouting.data.game = int.tryParse(value);
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
                      builder: (context) => const SummationPage(),
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

  List<DropdownMenuEntry> getTeamDropdownEntries() {
    List<DropdownMenuEntry> entries = [];
    if (teams.isNotEmpty) {
      for (var team in teams) {
        entries.add(DropdownMenuEntry(label: team, value: team));
      }
    }

    return entries;
  }
}
