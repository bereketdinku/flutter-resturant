import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/widget/btn_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/consts.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).make(),
        Divider(),
        10.heightBox,
        "Are you sure want to exit".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            btnWidget(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            btnWidget(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No")
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
