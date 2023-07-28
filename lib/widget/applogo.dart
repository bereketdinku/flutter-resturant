import 'package:flutter/material.dart';
import 'package:my_try/consts/consts.dart';
import "package:velocity_x/velocity_x.dart";

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
