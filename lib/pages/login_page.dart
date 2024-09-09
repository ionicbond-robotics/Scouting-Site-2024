// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:scouting_site/pages/home_page.dart';
import 'package:scouting_site/services/firebase/firebase_api.dart';
import 'package:scouting_site/services/localstorage.dart';
import 'package:scouting_site/widgets/dialog_widgets/dialog_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggedIn = false;
  bool _showPassword = false;
  String _password = "";

  @override
  void initState() {
    super.initState();

    if (localStorage?.getString("password") != null) {
      // print(localStorage?.getString("password"));
      validatePassword(localStorage?.getString("password") ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (router) => false,
      );
    }

    return AlertDialog(
      content: SizedBox(
        height: 100,
        width: 350,
        child: Row(
          children: [
            Expanded(
              child: DialogTextInput(
                initialText: localStorage?.getString("password"),
                obscureText: !_showPassword,
                onSubmit: (value) {},
                onChanged: (value) {
                  _password = value ?? "";
                },
                label: "Login Password",
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _showPassword = true;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      _showPassword = false;
                    });
                  },
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            validatePassword(_password);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }

  void validatePassword(String password) async {
    if (password.isEmpty) return;

    final (passwordData, successful) =
        await DatabaseAPI.instance.downloadJson("password", "password");

    if (!successful) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Text(
                    "Wrong password!",
                    textScaler: TextScaler.linear(2),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                ],
              ));
    } else {
      if (password == passwordData['password']) {
        localStorage!.setString("password", password);

        setState(() {
          _loggedIn = true;
        });
      }
    }
  }
}
