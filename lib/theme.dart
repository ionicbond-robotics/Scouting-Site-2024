// Flutter imports:
import 'package:flutter/material.dart';

class GlobalIcons {
  static const Icon nextPageIcon = Icon(Icons.arrow_forward_ios_outlined);
}

class GlobalColors {
  static Color primaryColor = Colors.black;
  static const Color teamColor = Color.fromRGBO(255, 102, 196, 1);
  static const Color appBarColor = Colors.black;
  static Color get backgroundColor {
    if (primaryColor == Colors.white) return primaryColor;
    return const Color.fromRGBO(30, 30, 30, 255);
  }

  static Color get backButtonColor {
    return Colors.white;
  }
}
