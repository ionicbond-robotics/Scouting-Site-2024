class Question {
  final AnswerType type;
  final String questionText;
  Object? answer;
  List<Object?>? options;

  Question({
    required this.type,
    required this.questionText,
    this.options,
  }) {
    if (options != null && options!.isNotEmpty) {
      if (type == AnswerType.counter) {
        if (options!.length != 3) {
          if (options!.length == 1) {
            options = [options![0], null, null];
          } else if (options!.length == 2) {
            options = [options![0], options![1], null];
          }
        } else if (options!.length > 3) {
          throw ArgumentError(
            'A counter question must have options with length of 3 provided (initial, min, max). Cannot be greater than 3',
          );
        }
      }
    }
    if ((type == AnswerType.dropdown ||
            type == AnswerType.multipleChoice ||
            type == AnswerType.counter) &&
        (options == null || (options?.isEmpty ?? true))) {
      throw ArgumentError(
        'An enumerated question must have options provided. Options cannot be null.',
      );
    }
  }
}

enum AnswerType {
  integer,
  number,
  text,
  dropdown,
  checkbox,
  multipleChoice,
  counter,
}
