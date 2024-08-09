import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scouting_site/services/database/api.dart';
import 'package:scouting_site/services/scouting/form_data.dart';
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/question.dart';
import 'package:scouting_site/services/scouting/scouting.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';

class SummationPage extends StatefulWidget {
  const SummationPage({super.key});

  @override
  State<StatefulWidget> createState() => _SummationPageState();
}

class _SummationPageState extends State<SummationPage> {
  List<FormData> _formsData = [];

  Map<int, Map<String, List<FormData>>> gamesDataMap =
      {}; // Game |-> (Team |-> entries)

  String _sortBy = "game";

  @override
  Widget build(BuildContext context) {
    getDocuments();

    switch (_sortBy) {
      case "game":
        sortByGame(_formsData);
        break;
      case "scouter":
        sortByScouter(_formsData);
        break;
      case "team":
        sortByTeam(_formsData);
        break;
      default:
        sortByPage(_formsData, _sortBy);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBackButton,
          tooltip: "Back",
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Summation",
          style: TextStyle(
            color: GlobalColors.teamColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              DialogTextInput(
                onSubmit: (value) {},
                label: "Search",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            children: [
                              const Text(
                                "Scouter",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _sortBy = "scouter";
                                    });
                                  },
                                  icon: const Icon(Icons.sort_outlined))
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            children: [
                              const Text(
                                "Team",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _sortBy = "team";
                                    });
                                  },
                                  icon: const Icon(Icons.sort_outlined))
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            children: [
                              const Text(
                                "Game",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _sortBy = "game";
                                    });
                                  },
                                  icon: const Icon(Icons.sort_outlined))
                            ],
                          ),
                        ),
                      ),
                      ...getPagesDataColumns(_formsData),
                      const DataColumn(
                        label: Text("Actions"),
                      ),
                    ],
                    rows: getDataTableRows(),
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

  void getDocuments() async {
    QuerySnapshot<Map<String, dynamic>>? snapshot = await DatabaseAPI
        .instance.firestore
        ?.collection("scouting_${Scouting.competitionName}")
        .get();

    if (snapshot != null) {
      List<Map<String, dynamic>> data =
          snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        _formsData = data.map((scout) {
          return FormData.fromJson(scout);
        }).toList();
      });
    }
  }

  List<DataRow> getDataTableRows() {
    List<DataRow> rows = [];
    for (FormData form in _formsData) {
      rows.add(DataRow(cells: [
        DataCell(Text(form.scouter ?? "")),
        DataCell(Text(form.scoutedTeam ?? "")),
        DataCell(Text(form.game?.toString() ?? "0")),
        ...getPagesDataRows(pages: _formsData.first.pages, data: form.pages),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.expand_more),
                tooltip: "Answers",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "${form.scoutedTeam} - Game #${form.game} by ${form.scouter}"),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...getAnswersWidgetsForDialog(form)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ]));
    }

    return rows;
  }

  List<Widget> getAnswersWidgetsForDialog(FormData form) {
    List<Widget> answersWidgets = [];

    for (FormPageData page in form.pages) {
      answersWidgets.add(Text(
        page.pageName,
        textScaler: const TextScaler.linear(1.5),
      ));
      for (Question question in page.questions) {
        answersWidgets.add(Text(
          "${question.questionText}: ${question.answer}",
          textScaler: const TextScaler.linear(1.2),
        ));
      }
      answersWidgets.add(const Divider());
      answersWidgets.add(const SizedBox(height: 5));
    }

    answersWidgets.add(const SizedBox(height: 5));
    answersWidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.close_outlined),
            iconSize: 20,
            tooltip: "Close",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return answersWidgets;
  }

  void sortByGame(List<FormData> formsData) {
    formsData.sort((form1, form2) {
      final game1 = form1.game ?? 0;
      final game2 = form2.game ?? 0;
      return game1.compareTo(game2);
    });
  }

  void sortByScouter(List<FormData> formsData) {
    formsData.sort((form1, form2) {
      String scouter1 = form1.scouter ?? "";
      String scouter2 = form2.scouter ?? "";
      return scouter1.compareTo(scouter2);
    });
  }

  void sortByTeam(List<FormData> formsData) {
    formsData.sort((form1, form2) {
      String scouter1 = form1.scoutedTeam ?? "";
      String scouter2 = form2.scoutedTeam ?? "";

      int number1 = extractNumber(scouter1);
      int number2 = extractNumber(scouter2);

      return number1.compareTo(number2);
    });
  }

  int extractNumber(String scoutedTeam) {
    // Split by the '#' character and parse the number

    List<String> parts = scoutedTeam.split('#');
    if (parts.length > 1) {
      return int.tryParse(parts[1].trim()) ?? 0;
    }

    return 0; // Return 0 if the format is incorrect or parsing fails
  }

  void sortByPage(List<FormData> formsData, String pageName) {
    formsData.sort((form1, form2) {
      double value1 = form1.pages
          .firstWhere((page) => page.pageName == pageName)
          .evaluate();

      double value2 = form2.pages
          .firstWhere((page) => page.pageName == pageName)
          .evaluate();

      return value1.compareTo(value2);
    });
  }

  List<DataColumn> getPagesDataColumns(List<FormData> formsData) {
    List<DataColumn> columns = [];

    if (formsData.isNotEmpty) {
      for (FormPageData page in formsData.first.pages) {
        columns.add(
          DataColumn(
            label: Expanded(
              child: Row(
                children: [
                  Text(
                    page.pageName,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _sortBy = page.pageName;
                        });
                      },
                      icon: const Icon(Icons.sort_outlined))
                ],
              ),
            ),
          ),
        );
      }
    }
    columns.add(DataColumn(
      label: Expanded(
        child: Row(
          children: [
            const Text(
              "Total Score",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    // _sortBy = "total_score";
                  });
                },
                icon: const Icon(Icons.sort_outlined))
          ],
        ),
      ),
    ));

    return columns;
  }

  List<DataCell> getPagesDataRows(
      {required List<FormPageData> pages, required List<FormPageData> data}) {
    List<DataCell> cells = [];
    List<String> pageNames = pages.map((page) => page.pageName).toList();
    double totalScore = 0;
    for (FormPageData page in data) {
      if (pageNames.contains(page.pageName)) {
        if (data.map((page_) => page_.pageName).contains(page.pageName)) {
          double score = page.evaluate();
          cells.add(DataCell(Text(score.toString())));
          totalScore += score;
        } else {
          cells.add(DataCell.empty);
        }
      }
    }

    cells.add(DataCell(Text(totalScore.toString())));

    return cells;
  }
}
