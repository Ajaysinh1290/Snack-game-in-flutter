import 'package:flutter/material.dart';

class ColorPallette {
  static final Color darkBlue = Color(0xff11141c);
  static final Color controlColor = Colors.grey[400];
  static final Color canvasColor = ColorPallette.darkBlue;
  static final Color controlContainerColor = ColorPallette.darkBlue;
  static final Color snackColor = Colors.red;
  static final Color eggColor = Colors.pinkAccent;
  static final Color canvasBorderColor = Colors.grey[900];
  static final Color scoreTextColor = Colors.grey[400];
}

class SnackAndAggColors {
  static List colorsName = [
    'cyan',
    'pink_accent',
    'yellow',
    'blue',
    'green',
    'purple',
    'orange',
    'red'
  ];

  Map<String, String> colorsCode = {
    colorsName[0]: 'OxFF00BCD4',
    colorsName[1]: 'OxFFEC407A',
    colorsName[2]: 'OxFFFFEB3B',
    colorsName[3]: 'OxFF42A5F5',
    colorsName[4]: 'OxFF4CAF50',
    colorsName[5]: 'OxFFAB47BC',
    colorsName[6]: 'OxFFFFAB40',
    colorsName[7]: 'OxFFFF5252'
  };

  static List colors = [
    'FF00BCD4',
    'FFEC407A',
    'FFFFEB3B',
    'FF42A5F5',
    'FF4CAF50',
    'FFAB47BC',
    'FFFFAB40',
    'FFFF5252'
  ];
}
