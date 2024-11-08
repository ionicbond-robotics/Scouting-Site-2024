class Question {
  final AnswerType type;
  final String questionText;
  Object? answer;
  List<Object?>? options;
  final Object evaluation;
  final double _score;

  Question({
    required this.type,
    required this.questionText,
    this.options = const [],
    this.answer,
    this.evaluation = 0.0,
    score = 0.0,
  }) : _score = score {
    _validateArguments();
  }

  double get score => _score;

  void _validateArguments() {
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

  Map<String, dynamic> toJson() {
    _validateAnswer();

    if (type == AnswerType.checkbox && answer == null) {
      answer = false;
    }

    return {
      'type': type.toString().split('.').last, // Converts enum to string
      'questionText': questionText,
      'answer': answer,
      'options': options,
      'evaluation': evaluation,
      'score': evaluate(),
    };
  }

  void _validateAnswer() {
    if (type == AnswerType.multipleChoice) {
      if (answer == null) {
        answer = <String, dynamic>{};
        for (Object? option in (options ?? [])) {
          if (option != null) {
            (answer! as Map<String, dynamic>)[option.toString()] = false;
          }
        }
      } else {
        for (String key in (answer as Map<String, dynamic>).keys) {
          if ((answer as Map<String, dynamic>)[key] != true) {
            (answer as Map<String, dynamic>)[key] = false;
          }
        }
      }
    }
  }

  double evaluate() {
    double res = 0;

    switch (type) {
      case AnswerType.text:
        break;
      case AnswerType.dropdown:
        res = evaluateDropdown();
        break;
      case AnswerType.multipleChoice:
        res = evaluateMultipleChoice();
        break;
      case AnswerType.checkbox:
        res = (evaluation as num) * (((answer ?? false) as bool) ? 1.0 : 0.0);
        break;
      default:
        res = (evaluation as double) * ((answer ?? 0) as num);
    }
    return res;
  }

  static Question fromJson(Map<String, dynamic> json) {
    AnswerType type = _stringToAnswerType(json['type']);

    return Question(
      type: type,
      questionText: json['questionText'],
      options: json['options']?.cast<dynamic>(),
      answer: json['answer'] ?? (type == AnswerType.checkbox ? false : null),
      score: json['score'] as double,
    );
  }

  static AnswerType _stringToAnswerType(String type) {
    switch (type) {
      case 'integer':
        return AnswerType.integer;
      case 'number':
        return AnswerType.number;
      case 'dropdown':
        return AnswerType.dropdown;
      case 'checkbox':
        return AnswerType.checkbox;
      case 'multipleChoice':
        return AnswerType.multipleChoice;
      case 'text':
        return AnswerType.text;
      case 'counter':
        return AnswerType.counter;
      default:
        throw FormatException('Unknown AnswerType: $type');
    }
  }

  double evaluateDropdown() {
    Map<String, num> valuesMap = evaluation as Map<String, num>;
    return (valuesMap[answer ?? valuesMap.keys.first] ?? 0.0) as double;
  }

  double evaluateMultipleChoice() {
    double res = 0;
    Map<String, num> valuesMap = evaluation as Map<String, num>;

    for (String option in valuesMap.keys) {
      res += (((answer as Map<String, bool>)[option] ?? false) ? 1.0 : 0.0) *
          (valuesMap[option] ?? 0.0);
    }

    return res;
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
