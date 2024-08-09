import 'package:scouting_site/services/scouting/form_page_data.dart';

class FormData {
  List<FormPageData> pages = [];
  String? scouter;
  String? scoutedTeam;
  int? game;
  final double score;

  FormData({
    required this.pages,
    this.scoutedTeam,
    required this.scouter,
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
