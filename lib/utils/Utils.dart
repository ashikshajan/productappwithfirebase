// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtil {
  static String appName = "";
  static var appVersion = "1.0.2";

  static var isDebug = true;

// - - - - - - - APP Colors
  static Color appprimaryclr = const Color(0xff47339C);

  static var rupeeSymbol = "\u{20B9}";

  static Color appbtnclr = const Color(0xffFFBF1E);
  static Color appclrwhite = Colors.white;
  static Color appLightBlue = const Color(0xfff1ecff);
// - - - - - - - App TextStyles

  // static TextStyle bttntxt = GoogleFonts.poppins(
  //   textStyle: const TextStyle(
  //       color: Color(0xff272727),
  //       fontSize: 22,
  //       letterSpacing: .5,
  //       fontWeight: FontWeight.w500),
  // );

  static Size screensize(context) {
    var size = MediaQuery.of(context).size;
    return size;
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input; // Return the input string if it's empty
  }

  // Capitalize the first letter and concatenate with the rest of the string
  return input[0].toUpperCase() + input.substring(1);
}

class Log {
  static void print(dynamic msg, {other}) {
    // if (AppUtil.isDebug) {
    debugPrint("${other ?? ""} ${msg.toString()}");
    log("${other ?? ""} ${msg.toString()}");
    // }
  }
}

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}

String assetImages(String imagename) {
  return 'assets/images/$imagename';
}
