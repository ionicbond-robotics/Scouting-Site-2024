// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
// Project imports:
import 'package:scouting_site/pages/form_page.dart';
import 'package:scouting_site/services/firebase/firebase_api.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/services/scouting/form_data.dart';
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/question.dart';

class Scouting {
  static final List<FormPageData> _pages = [
    FormPageData(
      pageName: "Autonomous",
      questions: [
        Question(
          type: AnswerType.text,
          questionText: "Notes amount",
          evaluation: 2.0,
        ),
        Question(
          type: AnswerType.dropdown,
          questionText: "Start position",
          options: [
            "Top",
            "Middle",
          ],
          evaluation: {
            "Top": 1.0,
            "Middle": 2.0,
          },
        ),
        Question(
          type: AnswerType.checkbox,
          questionText: "Autonomous?",
          evaluation: 5.0,
        ),
        Question(
          type: AnswerType.multipleChoice,
          options: [
            "Yes",
            "No",
            "Brocolli",
          ],
          questionText: "How many?",
          evaluation: {
            "Yes": 1.0,
            "No": 3.0,
            "Brocolli": 4.0,
          },
        ),
        Question(
          type: AnswerType.number,
          questionText: "Your opinion about canibalism",
          evaluation: 12.0,
        ),
        Question(
          type: AnswerType.counter,
          questionText: "Did they do it?",
          options: [
            0, // initial
            0, // min
          ],
          evaluation: 2.0,
        ),
      ],
    ),
  ];

  static const String _tbaAPIKey =
      "fHNgYvUmzk3iawp0SC8XCIzePCWIE4kbZWMn6ypsL7VZ5NclTgcy9v0lbgXECA7E"; // example value, replace to use in your own project

  static (Map<int, List<String>>, Map<int, List<String>>) _matchesTeamsPair =
      ({}, {});

  static List<BuildContext> _pagesContexts = [];

  static const String competitionName = "2024isde1";

  static int _currentPage = -1;

  static FormData data = FormData(
    pages: _pages,
    scouter: localStorage?.getString("scouter"),
  );
  static bool hasInternet = true;

  static bool isOnLastPage() {
    return _currentPage >= _pages.length - 1;
  }

  static void _resetValues() {
    _currentPage = -1;
    _pagesContexts = [];
    data.game = null;
    data.scoutedTeam = null;

    for (FormPageData page in _pages) {
      for (Question question in page.questions) {
        question.answer = null;
      }
    }
  }

  static void setupConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        hasInternet = false;
      } else {
        hasInternet = true;
      }
    });
  }

  static Future<void> initialize() async {
    setupConnectivityListener();
    _resetValues();
    await DatabaseAPI.instance.initialize();

    if (localStorage == null) {
      loadLocalStorage();
    }

    await sendUnsentFormEntries();

    _matchesTeamsPair = await getEventTeams(competitionName);
  }

  static (Map<int, List<String>>, Map<int, List<String>>) matchesTeamsPair() =>
      _matchesTeamsPair;

  static Future<void> sendUnsentFormEntries() async {
    List<String>? formsToSend = localStorage
        ?.getKeys()
        .where((key) => key.startsWith("scout_"))
        .toList();

    if (formsToSend != null) {
      for (String formName in formsToSend) {
        String textData = localStorage?.getString(formName) ?? "";

        if (textData.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(textData);
          await sendData(jsonData, header: formName);
          await localStorage?.remove(formName);
        }
      }
    }
  }

  static int getPageCount() {
    return _pages.length;
  }

  static FormPage generateCurrentPage() {
    return FormPage(data: _pages[_currentPage]);
  }

  static void advance(BuildContext context) {
    if (_pages.length - 1 > _currentPage) {
      _currentPage++;

      _pagesContexts.add(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Scouting.generateCurrentPage()));
    }
  }

  static bool _isIndexValid(int index) {
    return _pages.length - 1 > _currentPage;
  }

  static String getNextPageName() {
    return (_isIndexValid(_currentPage + 1)
        ? _pages[_currentPage + 1].pageName
        : "Unknown");
  }

  static void onPagePop() {
    _currentPage--;
  }

  static int getCurrentPageNumber() {
    return _currentPage;
  }

  static Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> pagesJson =
        _pages.map((page) => page.toJson()).toList();

    return {
      'pages': pagesJson,
      'scouter': data.scouter,
      'scouted_on': data.scoutedTeam,
      'game': data.game,
      'score': data.evaluate(),
    };
  }

  static List<FormPageData> fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    List<FormPageData> pages = (jsonMap['pages'] as List<dynamic>)
        .map((item) => FormPageData.fromJson(item as Map<String, dynamic>))
        .toList();

    return pages;
  }

  static Future<void> sendData(Map<String, dynamic> json,
      {String? header}) async {
    for (int i = 0; i < _pagesContexts.length; i++) {
      Navigator.pop(_pagesContexts[i]);
    }

    header ??= "${DateTime.now()} ${data.scouter ?? ""}";

    if (hasInternet) {
      DatabaseAPI.instance
          .uploadJson(json, 'scouting_$competitionName', header);
    } else {
      localStorage?.setString("scout_$header", jsonEncode(json));
    }

    _resetValues();
  }

  static Future<(Map<int, List<String>>, Map<int, List<String>>)> getEventTeams(
      String eventKey) async {
    const String apiUrl = 'https://www.thebluealliance.com/api/v3';

    final response = await http.get(
        Uri.parse("$apiUrl/event/$eventKey/matches/simple"),
        headers: {'X-TBA-Auth-Key': _tbaAPIKey});

    final jsonResponse = jsonDecode(response.body);

    Map<int, List<String>> redAlliance = {};
    Map<int, List<String>> blueAlliance = {};

    if (jsonResponse is List<dynamic>) {
      for (var match in jsonResponse) {
        final alliancesObjects = match["alliances"];
        List<String> currentGameRed = [];
        List<String> currentGameBlue = [];

        for (var teamKey in alliancesObjects["red"]["team_keys"]) {
          currentGameRed
              .add(teamKey.toString().substring(3)); // remove the frc prefix
        }
        for (var teamKey in alliancesObjects["blue"]["team_keys"]) {
          currentGameBlue
              .add(teamKey.toString().substring(3)); // remove the frc prefix
        }

        redAlliance[match["match_number"] as int] = currentGameRed;
        blueAlliance[match["match_number"] as int] = currentGameBlue;
      }
    }
    // print(jsonResponse);
    return (
      redAlliance,
      blueAlliance,
    );
  }
}
