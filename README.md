# Scouting Site

A base scouting site for FTC / FRC (Or any competition alike) teams.

# Getting Started
First off, fork this repository by pressing the [`Fork`](https://github.com/DanPeled/Scouting-Tool/fork) button located on the top of this repository page.

## Requirements:
1. [Dart](https://dart.dev/get-dart) & [Flutter](https://docs.flutter.dev/get-started/install) installed.
2. A [Firebase](https://firebase.google.com/) project with a [Firestore Database](https://firebase.google.com/docs/firestore) & the `web` option configured.

## Setting up your database in-code
Go to the [`lib/services/database/api.dart`](https://github.com/DanPeled/Scouting-Tool/blob/master/lib/services/database/api.dart) file and modify the following lines to use your firebase project details:
```dart
Future<void> initialize() async {
    // ...
	app = await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "<your apiKey>",
        appId: "<your appId>",
        messagingSenderId: "<your messaginSenderId>",
        projectId: "<your projectId>",
        storageBucket: "<your storage Bucket>",
      ),
    );
	// ...
  }
```

## Setting up custom question & pages
Go to the [`lib/services/scouting/scouting.dart`](https://github.com/DanPeled/Scouting-Tool/blob/master/lib/services/scouting/scouting.dart) file and modify the `pages` `List<FormPageData>` located at the top of the class. 

e.g : 
```dart
static List<FormPageData> _pages = [
    FormPageData(
      pageName: "Autonomous",
      questions: [
        Question(
          type: AnswerType.text,
          questionText: "Notes amount",
        ),
        Question(
          type: AnswerType.dropdown,
          questionText: "Start position",
          options: [
            "Top",
            "Middle",
          ],
        ),
        Question(
          type: AnswerType.checkbox,
          questionText: "Autonomous?",
        ),
        Question(
          type: AnswerType.multipleChoice,
          options: [
            "Yes",
            "No",
            "Brocolli",
          ],
          questionText: "How many?",
        ),
        Question(
          type: AnswerType.number,
          questionText: "Your opinion about canibalism",
        ),
        Question(
          type: AnswerType.counter,
          questionText: "Did they do it?",
          options: [
            0, // initial
            0, // min
          ],
        ),
      ],
    )
  ];
  ```

# Documentation
...