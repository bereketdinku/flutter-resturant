import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/screens/categories/items.dart';
import 'package:my_try/widget/bg_widget.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/consts.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestore.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  // var controller = Get.put<ProductController>();
  var controller = Get.put(ProductController());
  dynamic productMethod;
  @override
  void initState() {
    super.initState();
    swichCategory(widget.title);
  }

  swichCategory(title) {
    if (controller.subcat.contains(title)) {
      // productMethod = FirestoreServices.getsubCategory(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.title!.text.fontFamily(bold).black.make(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          // 6,
                          (index) => "${controller.subcat[index]}"
                                  // "Auto"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .size(90, 50)
                                  .rounded
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {
                                swichCategory("${controller.subcat[index]}");
                                setState(() {});
                              }))),
                ),
                10.heightBox,
                StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Container(
                          child: loadingIndicator(),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: "No products found!"
                              .text
                              .color(darkFontGrey)
                              .make(),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return Expanded(
                          child: Container(
                        color: lightGrey,
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 200),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Image.network(
                                    data[index]['p_imgs'][0],
                                    height: 100,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                  5.heightBox,
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .size(18)
                                      .make(),
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make()
                                      .onTap(() {
                                    controller.checkIfFav(data[index]);
                                    Get.to(() => ItemDetail(
                                          title: "${data[index]['p_name']}",
                                          data: data[index],
                                        ));
                                  })
                                ],
                              )
                                  .box
                                  .white
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .padding(EdgeInsets.all(10))
                                  .make();
                            }),
                      ));
                    }
                  },
                ),
              ],
            )));
  }
}
