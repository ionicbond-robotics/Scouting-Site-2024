class Question {
  final AnswerType type;
  final String question;
  Object? answer;
  final List<Object>? options;

  Question({
    required this.type,
    required this.question,
    this.options,
  }) {
    if (type == AnswerType.enumerated && options == null) {
      throw ArgumentError(
        'An enumerated question must have options provided. Options cannot be null.',
      );
    }
  }
}

enum AnswerType {
  number,
  text,
  enumerated,
}
