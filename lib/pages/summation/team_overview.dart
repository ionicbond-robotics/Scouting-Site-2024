import 'package:flutter/material.dart';
import 'package:scouting_site/services/scouting/form_data.dart';
import 'package:scouting_site/services/scouting/helper_methods.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_toggle_switch.dart';

class TeamOverviewPage extends StatefulWidget {
  final int team;
  final List<FormData> forms;

  const TeamOverviewPage({super.key, required this.team, required this.forms});

  @override
  State<TeamOverviewPage> createState() => _TeamOverviewPageState();
}

class _TeamOverviewPageState extends State<TeamOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _handleBackButton,
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back",
          color: GlobalColors.backButtonColor,
        ),
        backgroundColor: GlobalColors.appBarColor,
        title: Text(
          "#${widget.team} Overview",
          style: const TextStyle(
            color: GlobalColors.teamColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: GlobalColors.backgroundColor,
          child: Row(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: getQuestionColumn(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBackButton() {
    Navigator.of(context).pop();
  }

  List<Widget> getQuestionColumn() {
    List<Widget> questions = [];

    widget.forms
        .where((form) => extractNumber(form.scoutedTeam ?? "") == widget.team)
        .toList()
        .first
        .pages
        .forEach((page) {
      questions.add(Text(
        page.pageName,
        textScaler: const TextScaler.linear(1.6),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));

      for (var question in page.questions) {
        questions.add(
          SizedBox(
            width: 500,
            height: 40,
            child: DialogToggleSwitch(
              onToggle: (value) {},
              label: question.questionText,
            ),
          ),
        );
      }

      questions.add(const Divider());
    });

    return questions;
  }
}
