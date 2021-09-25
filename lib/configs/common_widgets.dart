import 'package:flutter/material.dart';

class CommonWidgets {

  // ...
  static Widget text(
    String text, {
    int maxLines = 1,
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
    // ...
  }

  // ...
}
