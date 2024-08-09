import 'package:scouting_site/services/scouting/question.dart';

class FormPageData {
  final String pageName;
  final List<Question> questions;

  FormPageData({
    required this.pageName,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageName': pageName,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  static FormPageData fromJson(Map<String, dynamic> json) {
    return FormPageData(
      pageName: json['pageName'] as String,
      questions: (json['questions'] as List)
          .map((item) => Question.fromJson(item))
          .toList(),
    );
  }

  double evaluate() {
    // for (Question q in questions) {} // TODO
    return 0;
  }
}
