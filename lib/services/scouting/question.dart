class Question {
  final AnswerType type;
  final String questionText;
  Object? answer;
  final List<Object>? options;

  Question({
    required this.type,
    required this.questionText,
    this.options,
  }) {
    if (type == AnswerType.dropdown && options == null) {
      throw ArgumentError(
        'An enumerated question must have options provided. Options cannot be null.',
      );
    }
  }
}

enum AnswerType { number, text, dropdown, checkbox, multipleChoice }
