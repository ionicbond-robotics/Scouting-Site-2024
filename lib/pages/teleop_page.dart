import 'package:flutter/material.dart';
import 'package:scouting_site/pages/endgame_page.dart';
import 'package:scouting_site/theme.dart';

class TeleOpPage extends StatefulWidget {
  const TeleOpPage({super.key});

  @override
  State<TeleOpPage> createState() => _TeleOpPageState();
}

class _TeleOpPageState extends State<TeleOpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("TeleOp"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EndgamePage()));
            },
            tooltip: "Endgame",
            child: GlobalIcons.nextPageIcon,
          ),
        ],
      ),
    );
  }
}
