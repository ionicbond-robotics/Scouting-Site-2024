import 'package:scouting_site/services/scouting/question.dart';

class FormPageData {
  final String pageName;
  final List<Question> questions;

  FormPageData({
    required this.pageName,
    required this.questions,
  });
}
