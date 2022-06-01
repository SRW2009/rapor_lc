
import 'package:flutter/material.dart';

mixin CustomWidgetStyle {
  ButtonStyle dashboardBtnStyle = ButtonStyle(
    //padding: MaterialStateProperty.all(EdgeInsets.all(24)),
    textStyle: MaterialStateProperty.all(TextStyle(
      fontSize: 18,
    )),
  );
}