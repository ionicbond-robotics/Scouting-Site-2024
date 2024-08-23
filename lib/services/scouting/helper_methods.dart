// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:scouting_site/services/scouting/form_data.dart';

List<FormData> handleSearchQuery(
    List<FormData> forms, Map<String, dynamic> searchQuery) {
  if (searchQuery.isEmpty) return forms;

  List<FormData> modifiedForms = List.from(forms);
  searchQuery.forEach((key, value) {
    modifiedForms = forms.where((form) {
      try {
        switch (key) {
          case "game":
            return form.game == int.parse(value);
          case "score":
            return form.score == num.parse(value);
          case "team":
            return extractNumber(form.scoutedTeam ?? "") == int.parse(value);
          case "scouter":
            return form.scouter == value;
        }
      } catch (_) {}
      if (form.pages
          .map((page) => page.pageName.toLowerCase())
          .contains(key.toLowerCase())) {
        return form.pages
                .firstWhere(
                    (page) => page.pageName.toLowerCase() == key.toLowerCase())
                .score ==
            num.parse(value);
      }
      return true;
    }).toList();
  });

  return modifiedForms;
}

int extractNumber(String team) {
  if (int.tryParse(team) != null) {
    return int.parse(team);
  }
  // Split by the '#' character and parse the number

  List<String> parts = team.split('#');
  if (parts.length > 1) {
    return int.tryParse(parts[1].trim()) ?? 0;
  }

  return 0; // Return 0 if the format is incorrect or parsing fails
}

Map<String, dynamic> evaluateSearchQuery(String text) {
  // Split the input string into pairs
  List<String> pairs = text.split(',');

  // Create a map to store the key-value pairs
  Map<String, String> map = {};

  // Process each pair
  for (String pair in pairs) {
    // Split each pair into key and value
    List<String> parts = pair.split(':');

    if (parts.length == 2) {
      // Trim spaces from the key and value
      String key = parts[0].trim();
      String value = parts[1].trim();

      // Store the key-value pair in the map
      map[key] = value;
    } else {
      return {};
    }
  }

  return map;
}

Future<(Map<int, List<String>>, Map<int, List<String>>)> getEventTeams(
    String eventKey, String tbaApiKey) async {
  const String apiUrl = 'https://www.thebluealliance.com/api/v3';

  final response = await http.get(
      Uri.parse("$apiUrl/event/$eventKey/matches/simple"),
      headers: {'X-TBA-Auth-Key': tbaApiKey});

  final jsonResponse = jsonDecode(response.body);

  Map<int, List<String>> redAlliance = {};
  Map<int, List<String>> blueAlliance = {};

  if (jsonResponse["error"] != null) {
    throw ArgumentError(
        "Error while getting data from https://www.thebluealliance.com/api/v3");
  }

  if (jsonResponse is List<dynamic>) {
    for (var match in jsonResponse) {
      final alliancesObjects = match["alliances"];
      List<String> currentGameRed = [];
      List<String> currentGameBlue = [];

      for (var teamKey in alliancesObjects["red"]["team_keys"]) {
        currentGameRed
            .add(teamKey.toString().substring(3)); // remove the frc prefix
      }
      for (var teamKey in alliancesObjects["blue"]["team_keys"]) {
        currentGameBlue
            .add(teamKey.toString().substring(3)); // remove the frc prefix
      }

      redAlliance[match["match_number"] as int] = currentGameRed;
      blueAlliance[match["match_number"] as int] = currentGameBlue;
    }
  }
  // print(jsonResponse);
  return (
    redAlliance,
    blueAlliance,
  );
}

String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
