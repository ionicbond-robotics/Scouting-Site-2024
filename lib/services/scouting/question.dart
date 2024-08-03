class Question {
  final AnswerType type;
  final String question;
  Object? answer;

  Question({required this.type, required this.question});
}

enum AnswerType {
  number,
  text,
  enumerated,
}
