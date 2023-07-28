import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/consts.dart';

Widget btnWidget({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
    style: ElevatedButton.styleFrom(
        primary: color, padding: const EdgeInsets.all(12)),
  );
}
