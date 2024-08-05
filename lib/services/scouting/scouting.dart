import 'package:flutter/material.dart';
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/question.dart';
import 'package:scouting_site/widgets/form_page.dart';

class Scouting {
  static final List<FormPageData> _pages = [
    FormPageData(pageName: "Autonomous", questions: [
      Question(type: AnswerType.text, questionText: "Notes amount"),
      Question(
          type: AnswerType.dropdown,
          questionText: "Start position",
          options: ["Top", "Middle"]),
      Question(
        type: AnswerType.checkbox,
        questionText: "Autonomous?",
      ),
      Question(
        type: AnswerType.multipleChoice,
        options: ["Yes", "No", "Brocolli"],
        questionText: "How many?",
      )
    ])
  ];

  static bool isOnLastPage() {
    return _currentPage >= _pages.length - 1;
  }

  static int _currentPage = -1;

  static void initialize() {
    _currentPage = -1;
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
}
