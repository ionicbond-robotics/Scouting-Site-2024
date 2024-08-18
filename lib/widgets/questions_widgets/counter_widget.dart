import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int? min, max;
  final int intialValue;
  final String label;
  final Function(int value)? onValueChanged;
  final Function()? onValueReset;

  const CounterWidget(
      {super.key,
      required this.min,
      required this.max,
      required this.intialValue,
      required this.label,
      this.onValueChanged,
      this.onValueReset});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int currentValue = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.max != null && currentValue > widget.max!) {
      currentValue = widget.max!;
    }
    if (widget.min != null && currentValue < widget.min!) {
      currentValue = widget.min!;
    }

    return Column(
      children: [
        Text(
          widget.label,
          textScaler: const TextScaler.linear(1.2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                setState(() {
                  if (widget.max != null && currentValue + 1 > widget.max!) {
                    currentValue = widget.max!;
                  } else {
                    currentValue++;
                  }
                  widget.onValueChanged?.call(currentValue);
                });
              },
              icon: const Icon(
                Icons.add_outlined,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              currentValue.toString(),
              textScaler: const TextScaler.linear(1.4),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.min != null && currentValue - 1 < widget.min!) {
                    currentValue = widget.min!;
                  } else {
                    currentValue--;
                  }
                  widget.onValueChanged?.call(currentValue);
                });
              },
              iconSize: 30,
              icon: const Icon(
                Icons.remove_outlined,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            setState(() {
              currentValue = widget.intialValue;
              widget.onValueChanged?.call(currentValue);
              widget.onValueReset?.call();
            });
          },
          icon: const Icon(Icons.refresh_outlined),
        )
      ],
    );
  }
}
