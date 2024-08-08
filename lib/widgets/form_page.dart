import 'package:flutter/material.dart';
import 'package:scouting_site/services/scouting/form_page_data.dart';
import 'package:scouting_site/services/scouting/question.dart';
import 'package:scouting_site/services/scouting/scouting.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/question_widget.dart';

class FormPage extends StatefulWidget {
  final FormPageData data;

  const FormPage({super.key, required this.data});
  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
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
        title: Text(
          widget.data.pageName,
          style: const TextStyle(color: GlobalColors.teamColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: getQuestionWidgets(),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!Scouting.isOnLastPage())
            FloatingActionButton(
              tooltip: Scouting.getNextPageName(),
              onPressed: () {
                Scouting.advance(context);
              },
              heroTag: 2 + Scouting.getCurrentPageNumber(),
              child: GlobalIcons.nextPageIcon,
            )
          else
            FloatingActionButton(
              onPressed: () {
                Scouting.sendData(Scouting.toJson());
                Scouting.sendUnsentFormEntries();
              },
              tooltip: "Submit",
              child: const Icon(Icons.send_outlined),
            )
        ],
      ),
    );
  }

  void _handleBackButton() {
    Scouting.onPagePop();
    Navigator.of(context).pop();
  }

  List<Widget> getQuestionWidgets() {
    List<Widget> widgets = [];

    for (Question question in widget.data.questions) {
      widgets.add(const SizedBox(height: 5));
      widgets.add(QuestionWidget(question: question));
      widgets.add(const Divider());
    }

    return widgets;
  }
}
