import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_try/controllers/product_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/consts.dart';
import '../../widget/bg_widget.dart';
import 'details.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 150),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  categoriesImages[index],
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                5.heightBox,
                categoriesList[index]
                    .text
                    .white
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make()
              ],
            )
                .box
                .white
                .rounded
                .clip(Clip.antiAlias)
                .outerShadowSm
                .make()
                .onTap(() {
              controller.getSubCategories(categoriesList[index]);
              Get.to(() => CategoryDetails(
                    title: categoriesList[index],
                  ));
            });
          }),
    ));
  }
}
