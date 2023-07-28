import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/consts.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Column(
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 150,
          child: Column(
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2".text.make()
            ],
          ),
        )
      ],
    ),
  );
}
