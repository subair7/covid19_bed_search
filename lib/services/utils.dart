import 'package:flutter/material.dart';

class CommonColor {
  // static const Color primaryColor = Color(0xFF473F97);
  // static const Color primaryColor = Color(0xff007c7c);
  static const Color primaryColor = Color.fromARGB(255, 80, 41, 209);

}

class AppConstant {
  static const APP_TITLE = 'COVID-19';
}

class AppIcons {}

class Utils {
  static String listToString(List<String> list, String seperator) {
    String generatedString = '';
    if (list == null) {
      return '---';
    } else {
      list.forEach((element) {
        generatedString += element + seperator;
      });
      return generatedString;
    }
  }

  static String trimString(String strToTrim, [int trimLimit = 40]) {
    if (strToTrim.length > trimLimit) {
      return '${strToTrim.substring(0, trimLimit)}...';
    }
    return strToTrim;
  }
}
