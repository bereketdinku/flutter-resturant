import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/screens/categories/details.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 40, fit: BoxFit.fill),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .padding(const EdgeInsets.all(8))
      .white
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
