# Scouting Site

> A base scouting site for FTC / FRC (Or any competition alike) teams.

# Requirements:
1. [Dart](https://dart.dev/get-dart) & [Flutter](https://docs.flutter.dev/get-started/install) installed (Recommeneded, not neccessary).
2. [Git](https://git-scm.com/) installed (or modify from github, not recommended).
3. A [Firebase](https://firebase.google.com/) project with a [Firestore Database](https://firebase.google.com/docs/firestore) & the `web` option configured.

# Using the search functionality
On the `Summation` and `Averages` pages, exists a search bar that allows to search for specific entries in a simple way.
E.g If im looking for any team that has a score of 12 on the `autonomous` page, ill enter `autonomous:12`.

Or if im looking for all the entries of team `9738` from game # `12` ill do `team:9738, game:12`.  

## Supported Search Keys
|   Name    | Search key |
|  -------- |  --------  |
| Team (number only) | `team` |
| Game | `game` |
| Scouter | `scouter` |
| Total Score | `score` |
| Form Page | `pageName` |

* this list can be extended through the `handleSearchQuery` function on the [`lib/services/scouting/helper_methods.dart`](https://github.com/DanPeled/Scouting-Tool/blob/master/lib/services/scouting/helper_methods.dart) file
# Documentation
...

