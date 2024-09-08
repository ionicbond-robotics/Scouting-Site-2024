// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:scouting_site/pages/home_page.dart';
import 'package:scouting_site/theme.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';

void main() {
  testWidgets("Form Login", (WidgetTester widgetTester) async {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    bool isDarkMode = brightness == Brightness.dark;
    GlobalColors.primaryColor = isDarkMode ? Colors.black : Colors.white;

    await widgetTester.pumpWidget(
      MaterialApp(
        title: 'Scouting Site',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: GlobalColors.primaryColor,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );

    final scouterNameField =
        find.widgetWithText(DialogTextInput, "Scouter name");

    expect(scouterNameField, findsOneWidget);

    await widgetTester.enterText(scouterNameField, "Tester");
    await widgetTester.testTextInput.receiveAction(TextInputAction.done);
    await widgetTester.pumpAndSettle();

    final scoutingOnTeamField =
        find.widgetWithText(DropdownMenu, "Scouting On");

    expect(scoutingOnTeamField, findsOneWidget);

    final gameField = find.widgetWithText(DialogTextInput, "Game #");
    expect(gameField, findsOneWidget);
  });
}
