import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/consts.dart';

Widget detailCard({width, String? title, String? count}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).make(),
      3.heightBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.white.rounded.width(width).padding(const EdgeInsets.all(4)).make();
}
