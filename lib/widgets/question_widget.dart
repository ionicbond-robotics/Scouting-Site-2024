import 'package:flutter/material.dart';
import 'package:scouting_site/services/formatters/text_formatter_builder.dart';
import 'package:scouting_site/services/scouting/question.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';

class QuestionWidget extends StatelessWidget {
  final Question _question;

  const QuestionWidget({super.key, required Question question})
      : _question = question;

  @override
  Widget build(BuildContext context) {
    switch (_question.type) {
      case AnswerType.number:
        return DialogTextInput(
          onSubmit: (value) {
            _question.answer = value;
          },
          label: _question.question,
          formatter: TextFormatterBuilder.decimalTextFormatter(),
        );
      case AnswerType.enumerated:
        return DropdownMenu(
          label: Text(_question.question),
          dropdownMenuEntries: getDropdownOptions(),
          width: MediaQuery.of(context).size.width - 5,
          onSelected: (value) {
            _question.answer = value;
          },
        );
      case AnswerType.text:
        return DialogTextInput(
          onSubmit: (value) {
            _question.answer = value;
          },
          label: _question.question,
        );
    }
  }

  List<DropdownMenuEntry> getDropdownOptions() {
    List<DropdownMenuEntry> entries = [];

    if (_question.options == null) {
      return entries;
    }

    for (Object option in _question.options!) {
      entries.add(DropdownMenuEntry(value: option, label: option.toString()));
    }

    return entries;
  }
}
