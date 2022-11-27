
import 'package:flutter/material.dart';

mixin CustomWidgetStyle {
  ButtonStyle dashboardBtnStyle = ButtonStyle(
    //padding: MaterialStateProperty.all(EdgeInsets.all(24)),
    textStyle: MaterialStateProperty.all(TextStyle(
      fontSize: 18,
    )),
    fixedSize: MaterialStateProperty.all(Size.fromHeight(45)),
  );

  TextStyle settingHeaderStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );
  TextStyle settingTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  TextStyle settingDescStyle = TextStyle(
    fontSize: 16,
  );
}