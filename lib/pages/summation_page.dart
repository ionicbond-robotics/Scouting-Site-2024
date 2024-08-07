import 'package:flutter/material.dart';
import 'package:scouting_site/theme.dart';

class SummationPage extends StatefulWidget {
  const SummationPage({super.key});

  @override
  State<StatefulWidget> createState() => _SummationPageState();
}

class _SummationPageState extends State<SummationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBackButton,
          tooltip: "Back",
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Summation",
          style: TextStyle(
            color: GlobalColors.teamColor,
          ),
        ),
      ),
    );
  }

  void _handleBackButton() {
    Navigator.of(context).pop();
  }
}
