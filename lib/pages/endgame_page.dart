import 'package:flutter/material.dart';
import 'package:scouting_site/theme.dart';

class EndgamePage extends StatefulWidget {
  const EndgamePage({super.key});

  @override
  State<EndgamePage> createState() => _EndgamePageState();
}

class _EndgamePageState extends State<EndgamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Endgame"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Navigator.push(context,
              // MaterialPageRoute(builder: (context) => const PublishPage()));
            },
            tooltip: "Submit",
            child: GlobalIcons.nextPageIcon,
          ),
        ],
      ),
    );
  }
}
