import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:scouting_site/services/database/api.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/services/log.dart';
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/question.dart';
import 'package:scouting_site/widgets/form_page.dart';

class Scouting {
  static List<FormPageData> _pages = [
    FormPageData(
      pageName: "Autonomous",
      questions: [
        Question(
          type: AnswerType.text,
          questionText: "Notes amount",
        ),
        Question(
          type: AnswerType.dropdown,
          questionText: "Start position",
          options: [
            "Top",
            "Middle",
          ],
        ),
        Question(
          type: AnswerType.checkbox,
          questionText: "Autonomous?",
        ),
        Question(
          type: AnswerType.multipleChoice,
          options: [
            "Yes",
            "No",
            "Brocolli",
          ],
          questionText: "How many?",
        ),
        Question(
          type: AnswerType.number,
          questionText: "Your opinion about canibalism",
        ),
        Question(
          type: AnswerType.counter,
          questionText: "Did they do it?",
          options: [
            0, // initial
            0, // min
          ],
        ),
      ],
    )
  ];

  static List<BuildContext> _pagesContexts = [];
  static const String _competitionName = "test";
  static String? scouterName = localStorage?.getString("scouter");
  static String? scoutedTeam;
  static int? gameNumber;
  static bool hasInternet = true;
  static bool isOnLastPage() {
    return _currentPage >= _pages.length - 1;
  }

  static int _currentPage = -1;

  static void _resetValues() {
    _currentPage = -1;
    _pagesContexts = [];
    gameNumber = null;
    scoutedTeam = null;

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

    List<String>? formsToSend = localStorage
        ?.getKeys()
        .where((key) => key.startsWith("scout_"))
        .toList();

    if (formsToSend != null) {
      for (String formName in formsToSend) {
        String textData = localStorage?.getString(formName) ?? "";

        if (textData.isNotEmpty) {
          try {
            Map<String, dynamic> jsonData = jsonDecode(textData);
            await sendData(jsonData, header: formName);
            await localStorage?.remove(formName);
          } catch (e) {
            logger.error('Error decoding JSON for $formName: $e');
          }
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
      'scouter': scouterName,
      'scouted_on': scoutedTeam,
      'game': gameNumber,
    };
  }

  static void fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    List<FormPageData> pages = (jsonMap['pages'] as List<dynamic>)
        .map((item) => FormPageData.fromJson(item as Map<String, dynamic>))
        .toList();

    Scouting._pages = pages;
  }

  static Future<void> sendData(Map<String, dynamic> json,
      {String? header}) async {
    for (int i = 0; i < _pagesContexts.length; i++) {
      Navigator.pop(_pagesContexts[i]);
    }

    header ??= "${DateTime.now()} ${scouterName ?? ""}";

    if (hasInternet) {
      DatabaseAPI.instance
          .uploadJson(json, 'scouting_$_competitionName', header);
    } else {
      localStorage?.setString("scout_$header", jsonEncode(json));
    }

    _resetValues();
  }
}
