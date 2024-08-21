// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';

// Project imports:
import 'package:scouting_site/services/scouting/form_data.dart';
import 'package:scouting_site/services/scouting/helper_methods.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_toggle_switch.dart';

class TeamOverviewPage extends StatefulWidget {
  final int team;
  final List<FormData> forms;
  final List<FormData> avgs;

  const TeamOverviewPage(
      {super.key, required this.team, required this.forms, required this.avgs});

  @override
  State<TeamOverviewPage> createState() => _TeamOverviewPageState();
}

class _TeamOverviewPageState extends State<TeamOverviewPage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _handleBackButton,
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back",
          color: GlobalColors.backButtonColor,
        ),
        backgroundColor: GlobalColors.appBarColor,
        title: Text(
          "#${widget.team} Overview",
          style: const TextStyle(
            color: GlobalColors.teamColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: GlobalColors.backgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                height: 600,
                width: screenWidth - 100,
                child: getTotalScoreGraph(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 20,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 2),
                  Text("${widget.team}# Score"),
                  const SizedBox(width: 20),
                  Container(
                    height: 10,
                    width: 20,
                    color: Colors.blue.shade200,
                  ),
                  const SizedBox(width: 2),
                  const Text("Avg Global Score"),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBackButton() {
    Navigator.of(context).pop();
  }

  List<Widget> getQuestionSwitches() {
    List<Widget> questions = [];

    List<FormData> teamForms = widget.forms
        .where((form) => extractNumber(form.scoutedTeam ?? "") == widget.team)
        .toList();
    double switchesSize = (screenWidth > 500) ? 500 : screenWidth;

    for (var page in teamForms.first.pages) {
      questions.add(Text(
        page.pageName,
        textScaler: const TextScaler.linear(1.6),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));

      for (var question in page.questions) {
        questions.add(
          SizedBox(
            width: switchesSize,
            height: 40,
            child: DialogToggleSwitch(
              onToggle: (value) {},
              label: question.questionText,
            ),
          ),
        );
      }

      questions.add(const Divider());
    }

    return questions;
  }

  Widget getTotalScoreGraph() {
    Map<int, List<FormData>> gameForms = {};

    for (var form in widget.forms) {
      if (form.game != null) {
        gameForms.putIfAbsent(form.game!, () => []).add(form);
      }
    }

    Map<int, double> avgs = {};
    Map<int, double> teamScores = {};

    for (int game in gameForms.keys) {
      double currentGameSum = 0;
      int numberOfForms = gameForms[game]?.length ?? 0;

      if (numberOfForms > 0) {
        double sameGameScoreSum = 0;
        int sameGameAmount = 0;
        bool addTeamScore = false;
        for (FormData gameForm in gameForms[game] ?? []) {
          currentGameSum += gameForm.score;

          if (extractNumber(gameForm.scoutedTeam ?? "") == widget.team) {
            sameGameScoreSum += gameForm.score;
            sameGameAmount++;
            addTeamScore = true;
          }
        }

        if (addTeamScore) {
          teamScores[game] =
              (teamScores[game] ?? 0) + sameGameScoreSum / sameGameAmount;
        }

        avgs[game] = currentGameSum / numberOfForms;
      } else {
        avgs[game] = 0;
      }
    }
    double totalAvg = 0;

    avgs.forEach((game, avg) {
      totalAvg += avg;
    });

    totalAvg /= avgs.length;

    List<FlSpot> avgSpots = avgs.entries
        .map((entry) => FlSpot(
            entry.key.toDouble(), double.parse(totalAvg.toStringAsFixed(2))))
        .toList();

    List<FlSpot> teamSpots = teamScores.entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() == value) {
                  return Text(value.toInt().toString());
                } else {
                  return Container();
                }
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: (value, meta) {
                if (value.toInt() == value) {
                  return Text(value.toInt().toString());
                } else {
                  return Container();
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: avgSpots,
            isCurved: false,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: teamSpots,
            isCurved: false,
            dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 6, // Set your custom size for the second graph
                    color: Colors.red,
                    strokeWidth: 1,
                    strokeColor: Colors.black,
                  );
                }),
            color: Colors.red,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
