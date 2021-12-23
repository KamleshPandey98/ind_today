import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_styles.dart';

class ReusableWidgets {
  static final ReusableWidgets _reusableWidgets = ReusableWidgets._internal();
  factory ReusableWidgets() {
    return _reusableWidgets;
  }
  ReusableWidgets._internal();

  static Future showingFlutterToast(
      {required String msg, length, gravity, bgColor, textColor}) async {
    await Fluttertoast.cancel().then((value) {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: length ?? Toast.LENGTH_LONG,
        gravity: gravity ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor ?? CustomStyles.timerBgColor,
        textColor: textColor ?? CustomStyles.mainParentWhiteColor,
      );
    });
  }

  static pngLogoHolder({required String assetPath, height, width, color,
    required String text}) =>
      Column(
        children: [
          Image.asset(
            assetPath,
            height: height,
            width: width,
            color: color,
          ),
          Text(
            text,
            style: CustomStyles.navBarTxtStyle,
          ),
        ],
      );
}
