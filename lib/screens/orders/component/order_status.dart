import 'package:flutter/material.dart';
import 'package:my_try/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        title.text.color(darkFontGrey).make(),
        showDone ? Icon(icon, color: color) : Container()
      ]),
    ),
  );
}
