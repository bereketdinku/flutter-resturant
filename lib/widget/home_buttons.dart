import 'package:flutter/material.dart';
import 'package:my_try/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeButttons({width, height, String? title, icon, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.white.size(width, height).make();
}
