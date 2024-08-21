// Flutter imports:
import 'package:flutter/material.dart';

class MultiplechoiceWidget extends StatefulWidget {
  final String label;
  final List<String> options;
  List<bool>? values;
  final Function(List<bool> values)? onValueChanged;

  MultiplechoiceWidget(
      {super.key,
      required this.options,
      this.label = "",
      this.values,
      this.onValueChanged}) {
    if (options.isNotEmpty && values == null) {
      values = List.filled(options.length, false);
    }
  }

  @override
  State<MultiplechoiceWidget> createState() => _MultiplechoiceWidgetState();
}

class _MultiplechoiceWidgetState extends State<MultiplechoiceWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> entries = [];

    entries.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          widget.label,
          textScaler: const TextScaler.linear(1.3),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
    const double checkboxWidth = 40.0;

    if (widget.options.isNotEmpty) {
      for (int i = 0; i < widget.options.length; i++) {
        String optionString = widget.options[i];
        entries.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: checkboxWidth,
                child: Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    value: widget.values?[i] ?? false,
                    onChanged: (value) {
                      setState(() {
                        widget.values?[i] = value ?? false;
                        widget.onValueChanged?.call(widget.values ??
                            List.filled(widget.options.length, false));
                      });
                    },
                    semanticLabel: optionString,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  optionString,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1.2),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: entries,
    );
  }
}
