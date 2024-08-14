# Scouting Site

A base scouting site for FTC / FRC (Or any competition alike) teams.

# Getting Started
First off, fork this repository by pressing the [`Fork`](https://github.com/DanPeled/Scouting-Tool/fork) button located on the top of this repository page.

## Requirements:
1. [Dart](https://dart.dev/get-dart) & [Flutter](https://docs.flutter.dev/get-started/install) installed (Recommeneded, not neccessary).
2. [Git](https://git-scm.com/) installed (or modify from github, but less recommended).
3. A [Firebase](https://firebase.google.com/) project with a [Firestore Database](https://firebase.google.com/docs/firestore) & the `web` option configured.

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
static final List<FormPageData> _pages = [
    FormPageData(
      pageName: "Autonomous",
      questions: [
        Question(
          type: AnswerType.text,
          questionText: "Notes amount",
          evaluation: 2,
        ),
        Question(
          type: AnswerType.dropdown,
          questionText: "Start position",
          options: [
            "Top",
            "Middle",
          ],
          evaluation: {
            "Top": 1,
            "Middle": 2,
          },
        ),
        Question(
          type: AnswerType.checkbox,
          questionText: "Autonomous?",
          evaluation: 5,
        ),
        Question(
          type: AnswerType.multipleChoice,
          options: [
            "Yes",
            "No",
            "Brocolli",
          ],
          questionText: "How many?",
          evaluation: {
            "Yes": 1,
            "No": 3,
            "Brocolli": 4,
          },
        ),
        Question(
          type: AnswerType.number,
          questionText: "Your opinion about canibalism",
          evaluation: 12,
        ),
        Question(
          type: AnswerType.counter,
          questionText: "Did they do it?",
          options: [
            0, // initial
            0, // min
          ],
          evaluation: 2,
        ),
      ],
    ),
  ];
  ```
# Using the search functionality
On the `Summation` and `Averages` pages, exists a search bar that allows to search for specific entries in a simple way.
E.g If im looking for any team that has a score of 12 on the `autonomous` page, ill enter `autonomous:12`.

Or if im looking for all the entries of team `9738` ill do `team:9738`.  

## Supported Search Keys
|   Name    | Search key |
|  -------- |  --------  |
| Team | `team` |
| Game | `game` |
| Scouter | `scouter` |
| Total Score | `score` |
| Form Page | `pageName in lowercase` |

* this list can be extended through the `handleSearchQuery` function on the `lib/services/scouting/helper_methods.dart` file
# Documentation
...
