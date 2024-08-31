// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/scouting.dart';

class FormData {
  List<FormPageData> pages = [];
  String? scouter;
  String? scoutedTeam;
  int? game;
  MatchType matchType;
  final double score;

  FormData({
    required this.pages,
    required this.scouter,
    required this.matchType,
    this.scoutedTeam,
    this.game,
    this.score = 0,
  });

  static FormData fromJson(Map<String, dynamic> json) {
    List<FormPageData> pages = [];

    for (var element in json["pages"]) {
      if (element != null) pages.add(FormPageData.fromJson(element));
    }

    return FormData(
      pages: pages,
      scouter: json["scouter"],
      scoutedTeam: json["scouted_on"],
      game: json["game"],
      score: json["score"],
      matchType: MatchType.values.firstWhereOrNull(
              (match) => match.name == json["match_type"] as String?) ??
          MatchType.normal,
    );
  }

  double evaluate() {
    double res = 0.0;

    for (FormPageData page in pages) {
      res += page.evaluate();
    }

    return res;
  }
}
