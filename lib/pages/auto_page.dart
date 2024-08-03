import 'package:flutter/material.dart';
import 'package:scouting_site/pages/teleop_page.dart';
import 'package:scouting_site/theme.dart';

class AutonomousPage extends StatefulWidget {
  const AutonomousPage({super.key});

  @override
  State<AutonomousPage> createState() => _AutonomousPageState();
}

class _AutonomousPageState extends State<AutonomousPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Autonomous"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TeleOpPage()));
            },
            tooltip: "TeleOp",
            child: GlobalIcons.nextPageIcon,
          ),
        ],
      ),
    );
  }
}
